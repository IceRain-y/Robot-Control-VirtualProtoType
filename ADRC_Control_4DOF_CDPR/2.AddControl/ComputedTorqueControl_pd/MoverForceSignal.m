
%% Mover %%

mover.forceSignal = createForceSignal();

%% Mover Motion Signal %%

function forceSignal = createForceSignal()

% Initialize the motion signal for t = 0
forceSignal = initializeForceSignal;

% Compute the expected time for each bounce. Assume that the mover always
% returns to its starting height
t_bounce = 12;
t_bounces =-12:t_bounce:12;

% Compute time windows for the maneuvers between successive bounces. Include
% tolerances to ensure the mover has sufficient time to get back to starting
% position and not miss the ball.
t_windows = [t_bounces; circshift(t_bounces, -1)];

% Add translation maneuvers to move in circles in the x-y plane of the mover
amplitude = 0.25;

[forceSignal.fx, forceSignal.fy] = ...
  add_force(t_windows(:,2),amplitude, forceSignal.fx, forceSignal.fy);

end

function forceSignal = initializeForceSignal()

forceSignal.t_c = 0.01; % s

forceSignal.fx.time = 0; % s
forceSignal.fy.time = 0; % s
forceSignal.fz.time = 0; % s

forceSignal.fx.signals.values = 0.25;    % m
forceSignal.fy.signals.values = 0;    % m
forceSignal.fz.signals.values = 48.9; % m

forceSignal.fx0 = forceSignal.fx.signals.values(1);
forceSignal.fy0 = forceSignal.fy.signals.values(1);
forceSignal.fz0 = forceSignal.fz.signals.values(1);

end

function [fx, fy] = add_force(t_window,radius, fx, fy)

points = 100;

t = linspace(t_window(1), t_window(2), points)';

theta = linspace(0 * pi, 2 * pi, points)';

fx.time = [fx.time; t];
fy.time = [fy.time; t];

fx.signals.values = [fx.signals.values; radius * (cos(theta))];
fy.signals.values = [fy.signals.values; radius * (sin(theta))];

end
