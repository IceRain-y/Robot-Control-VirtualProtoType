
%% Mover %%

mover.motion1Signal = createMotion1Signal();

%% Mover Motion Signal %%

function motion1Signal = createMotion1Signal()

% Initialize the motion signal for t = 0
motion1Signal = initializeMotion1Signal;

% Compute the expected time for each bounce. Assume that the mover always
% returns to its starting height
t_bounce = 12;
t_bounces =-12:t_bounce:12;

% Compute time windows for the maneuvers between successive bounces. Include
% tolerances to ensure the mover has sufficient time to get back to starting
% position and not miss the ball.
t_windows = [t_bounces; circshift(t_bounces, -1)];

motion1Signal.ga = ...
  add_trace_ga_ptp(t_windows(:,2),+1, motion1Signal.ga);

end

function motion1Signal = initializeMotion1Signal()

motion1Signal.t_c = 0.01; % s

motion1Signal.ga.time = 0; % s

motion1Signal.ga.signals.values = -0.15;    % rad

motion1Signal.ga0 = motion1Signal.ga.signals.values(1);

end

function ga = add_trace_ga_ptp(t_window,dir,ga)

points = 100;

t = linspace(t_window(1), t_window(2), points)';

ga.time = [ga.time; t];

ga.signals.values = [ga.signals.values; dir .* ((4.43823867688403e-07) .* (t.^8) + (-2.31832170437498e-05) .* (t.^7) + 0.000500424954289551 .* (t.^6) + ...
(-0.00573217446498477) .* (t.^5) + (0.0369539235168457) .* (t.^4) + -0.128071968301542 .* (t.^3) + 0.182955836547261 .* (t.^2) + 0.0791673463646332 .* t + -0.160392610925979)];


end


