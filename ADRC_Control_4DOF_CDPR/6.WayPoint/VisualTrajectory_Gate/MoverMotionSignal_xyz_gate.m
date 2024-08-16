
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
  add_trace_gate(t_windows(:,2),+1, motionSignal.px, motionSignal.py, motionSignal.pz);

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

function [px, py,pz] = add_trace_gate(t_window,dir,px, py,pz)

points = 100;

t = linspace(t_window(1), t_window(2), points)';

px.time = [px.time; t];
py.time = [py.time; t];
pz.time = [pz.time; t];

px.signals.values = [px.signals.values; dir .* ((-0.474).*(0<=t&t<1.5)+(-0.474+(0.474+0.474).*s((t-1.5)./9)).*(1.5<=t&t<10.5)+(0.474).*(10.5<=t&t<=12))];
py.signals.values = [py.signals.values; dir .* ((-0.645).*(0<=t&t<1.5)+(-0.645+(0.645+0.645).*s((t-1.5)./9)).*(1.5<=t&t<10.5)+(0.645).*(10.5<=t&t<=12))];
pz.signals.values = [pz.signals.values; dir .* ((0.9+0.4.*s(t./3)).*(0<=t&t<3)+(0.9+0.4).*(3<=t&t<9)+(0.9+0.4-0.4.*s((t-9)./3)).*(9<=t&t<=12))];

end

function s= s(m)
s=-20.*(m.^7)+70.*(m.^6)-84.*(m.^5)+35.*(m.^4);
end



