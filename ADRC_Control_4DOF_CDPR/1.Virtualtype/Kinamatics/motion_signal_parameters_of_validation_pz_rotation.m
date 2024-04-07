
%% Mover %%

mover.motionSignal = createMotionSignal();

%% Mover Motion Signal %%

function motionSignal = createMotionSignal()

% Initialize the motion signal for t = 0
motionSignal = initializeMotionSignal;

% Compute the expected time for each bounce. Assume that the mover always
% returns to its starting height
%t_bounce = 0.586;
%t_bounces = 0.5 * t_bounce:t_bounce:10;

% Compute time windows for the maneuvers between successive bounces. Include
% tolerances to ensure the mover has sufficient time to get back to starting
% position and not miss the ball.
%t_windows = [t_bounces + 0.05; circshift(t_bounces, -1) - 0.1];

end

function motionSignal = initializeMotionSignal()

motionSignal.t_c = 0.01; % s

motionSignal.px.time = 0; % s
motionSignal.py.time = 0; % s
motionSignal.pz.time = 0; % s

motionSignal.px.signals.values = 0;    % m
motionSignal.py.signals.values = 0;    % m
motionSignal.pz.signals.values = 1.3; % m

motionSignal.px0 = motionSignal.px.signals.values(1);
motionSignal.py0 = motionSignal.py.signals.values(1);
motionSignal.pz0 = motionSignal.pz.signals.values(1);

end



