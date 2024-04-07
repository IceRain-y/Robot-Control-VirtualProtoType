
%% Mover %%

mover.jointmotion1Signal = createJointMotion1Signal();

%% Mover Motion Signal %%

function jointmotion1Signal = createJointMotion1Signal()

% Initialize the motion signal for t = 0
jointmotion1Signal = initializeJointMotion1Signal;

% Compute the expected time for each bounce. Assume that the mover always
% returns to its starting height
t_bounce = 6;
t_bounces =-6:t_bounce:12;

% Compute time windows for the maneuvers between successive bounces. Include
% tolerances to ensure the mover has sufficient time to get back to starting
% position and not miss the ball.
t_windows = [t_bounces; circshift(t_bounces, -1)];

% Add translation maneuvers to move in circles in the x-y plane of the mover
[jointmotion1Signal.q1, jointmotion1Signal.q3] = ...
  add_wave1(t_windows(:,2), jointmotion1Signal.q1,jointmotion1Signal.q3);
[jointmotion1Signal.q1,jointmotion1Signal.q3] = ...
  add_wave2(t_windows(:,3),jointmotion1Signal.q1,jointmotion1Signal.q3);
end

function jointmotion1Signal = initializeJointMotion1Signal()

jointmotion1Signal.t_c = 0.01; % s

jointmotion1Signal.q1.time = 0; % s
jointmotion1Signal.q3.time = 0; % s

jointmotion1Signal.q1.signals.values = 0;    % m
jointmotion1Signal.q3.signals.values = 0;    % m

jointmotion1Signal.q10 = jointmotion1Signal.q1.signals.values(1);
jointmotion1Signal.q30 = jointmotion1Signal.q3.signals.values(1);

end

function [q1,q3] = add_wave1(t_window, q1,q3)

points = 120;

%t = linspace(t_window(1), t_window(2), points)';
t1 = linspace(0, 4, 40)';

q1.time = [q1.time; t1];
q3.time = [q3.time; t1];

q1.signals.values = [q1.signals.values; -0.5 * (t1-2).^2 + 2];
q3.signals.values = [q3.signals.values; 0.5 * (t1-2).^2-2 ];

end

function [q1,q3] = add_wave2(t_window, q1,q3)

points = 120;

%t = linspace(t_window(1), t_window(2), points)';
t3 = linspace(4, 12, 80)';

q1.time = [q1.time; t3];
q3.time = [q3.time; t3];

q1.signals.values = [q1.signals.values; 0.5 * (t3-8).^2 - 8];
q3.signals.values = [q3.signals.values; -0.5 * (t3-8).^2 + 8];

end
