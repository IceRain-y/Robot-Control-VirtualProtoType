
%% Mover %%

mover.jointmotionSignal = createJointMotionSignal();

%% Mover Motion Signal %%

function jointmotionSignal = createJointMotionSignal()

% Initialize the motion signal for t = 0
jointmotionSignal = initializeJointMotionSignal;

% Compute the expected time for each bounce. Assume that the mover always
% returns to its starting height
t_bounce = 6;
t_bounces =-6:t_bounce:12;

% Compute time windows for the maneuvers between successive bounces. Include
% tolerances to ensure the mover has sufficient time to get back to starting
% position and not miss the ball.
t_windows = [t_bounces; circshift(t_bounces, -1)];

% Add translation maneuvers to move in circles in the x-y plane of the mover
[jointmotionSignal.q2, jointmotionSignal.q4] = ...
  add_wave1(t_windows(:,2), jointmotionSignal.q2,jointmotionSignal.q4);
[jointmotionSignal.q2,jointmotionSignal.q4] = ...
  add_wave2(t_windows(:,3),jointmotionSignal.q2,jointmotionSignal.q4);
end

function jointmotionSignal = initializeJointMotionSignal()

jointmotionSignal.t_c = 0.01; % s

jointmotionSignal.q2.time = 0; % s
jointmotionSignal.q4.time = 0; % s

jointmotionSignal.q2.signals.values = 0;    % m
jointmotionSignal.q4.signals.values = 0;    % m

jointmotionSignal.q20 = jointmotionSignal.q2.signals.values(1);
jointmotionSignal.q40 = jointmotionSignal.q4.signals.values(1);

end

function [q2,q4] = add_wave1(t_window, q2,q4)

points = 120;

%t = linspace(t_window(1), t_window(2), points)';
t2 = linspace(0, 8, 80)';

q2.time = [q2.time; t2];
q4.time = [q4.time; t2];

q2.signals.values = [q2.signals.values; -0.5 * (t2-4).^2 + 8];
q4.signals.values = [q4.signals.values; 0.5 * (t2-4).^2 - 8 ];

end

function [q2,q4] = add_wave2(t_window, q2,q4)

points = 120;

%t = linspace(t_window(1), t_window(2), points)';
t4 = linspace(8, 12, 40)';

q2.time = [q2.time; t4];
q4.time = [q4.time; t4];

q2.signals.values = [q2.signals.values; 0.5 * (t4-10).^2 - 2];
q4.signals.values = [q4.signals.values; -0.5 * (t4-10).^2 + 2];

end
