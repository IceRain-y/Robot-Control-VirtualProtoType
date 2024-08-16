
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

motion1Signal.ga.signals.values = 0;    % rad

motion1Signal.ga0 = motion1Signal.ga.signals.values(1);

end

function ga = add_trace_ga_ptp(t_window,dir,ga)

points = 100;

t = linspace(t_window(1), t_window(2), points)';

ga.time = [ga.time; t];

ga.signals.values = [ga.signals.values; dir .* 0.1 .* (-0.00054455 .* (t.^5) + 0.017127 .* (t.^4) + -0.18588 .* (t.^3) + 0.79593 .* (t.^2) + -1.0775 .* t + 0.08389)];


end


