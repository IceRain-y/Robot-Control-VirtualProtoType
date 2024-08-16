
%% Mover %%

mover.motionSignal = createMotionSignal();

%% Mover Motion Signal %%

function motionSignal = createMotionSignal()

% Initialize the motion signal for t = 0
motionSignal = initializeMotionSignal;

% Compute the expected time for each bounce. Assume that the mover always
% returns to its starting height
t_bounce = 12;
t_bounces =-12:t_bounce:12;

% Compute time windows for the maneuvers between successive bounces. Include
% tolerances to ensure the mover has sufficient time to get back to starting
% position and not miss the ball.
t_windows = [t_bounces; circshift(t_bounces, -1)];

[motionSignal.px, motionSignal.py,motionSignal.pz] = ...
  add_trace_ptp(t_windows(:,2),+1, motionSignal.px, motionSignal.py, motionSignal.pz);

end

function motionSignal = initializeMotionSignal()

motionSignal.t_c = 0.01; % s

motionSignal.px.time = 0; % s
motionSignal.py.time = 0; % s
motionSignal.pz.time = 0; % s

motionSignal.px.signals.values = -0.15;    % m
motionSignal.py.signals.values = -0.25;    % m
motionSignal.pz.signals.values = 1.2; % m

motionSignal.px0 = motionSignal.px.signals.values(1);
motionSignal.py0 = motionSignal.py.signals.values(1);
motionSignal.pz0 = motionSignal.pz.signals.values(1);

end

function [px, py,pz] = add_trace_ptp(t_window,dir,px, py,pz)

points = 100;

t = linspace(t_window(1), t_window(2), points)';

px.time = [px.time; t];
py.time = [py.time; t];
pz.time = [pz.time; t];

px.signals.values = [px.signals.values; dir .* ((3.547e-06) .* (t.^6) - 0.0001407 .* (t.^5) + 0.002127 .* (t.^4) - 0.01467 .* (t.^3) + 0.03765 .* (t.^2) + 0.04724 .* t - 0.159)];
py.signals.values = [py.signals.values; dir .* ((5.42e-06) .* (t.^6) - 0.0002145 .* (t.^5) + 0.003228 .* (t.^4) - 0.02202 .* (t.^3) + 0.05375 .* (t.^2) + 0.09175 .* t -0.2664)];
pz.signals.values = [pz.signals.values; dir .* ((8.098e-07) .* (t.^6) - (4.658e-05) .* (t.^5) + 0.001026 .* (t.^4) - 0.01089 .* (t.^3) + 0.05502 .* (t.^2) - 0.0943 .* t + 1.214)];

end


