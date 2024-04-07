
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

% Add translation maneuvers to move in circles in the x-y plane of the mover
circleRadius = 0.2;

[motionSignal.px, motionSignal.py] = ...
  add_circle(t_windows(:,2),+1,circleRadius, motionSignal.px, motionSignal.py);

end

function motionSignal = initializeMotionSignal()

motionSignal.t_c = 0.01; % s

motionSignal.px.time = 0; % s
motionSignal.py.time = 0; % s
motionSignal.pz.time = 0; % s

motionSignal.px.signals.values = 0.2;    % m
motionSignal.py.signals.values = 0;    % m
motionSignal.pz.signals.values = 1.3; % m

motionSignal.px0 = motionSignal.px.signals.values(1);
motionSignal.py0 = motionSignal.py.signals.values(1);
motionSignal.pz0 = motionSignal.pz.signals.values(1);

end

function [px, py] = add_circle(t_window,dir,radius, px, py)

points = 100;

t = linspace(t_window(1), t_window(2), points)';

theta = dir * linspace(0 * pi, 2 * pi, points)';

px.time = [px.time; t];
py.time = [py.time; t];

px.signals.values = [px.signals.values; radius * (cos(theta))];
py.signals.values = [py.signals.values; radius * (dir * sin(theta))];

end
