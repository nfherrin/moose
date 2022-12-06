[Optimization]
  optimization_type = MaterialSwapOpt
  #parameter_names = 'middle_temperature_line'
  #num_values = '3'
  #measurement_points = '0.0 5.0
  #                      5.0 5.0
  #                      10.0 5.0'
  #energy_function = 'middle_temperature_line[1]^2+middle_temperature_line[2]+middle_temperature_line[3]^3'
[]

[OptimizationReporter]
  type = OptimizationReporter
  parameter_names = 'pattern'
  num_values = '100'
[]

[MultiApps]
  [current_pattern]
    type = FullSolveMultiApp
    input_files = current_pattern.i
  []
[]

[Transfers]
  [params]
    type = MultiAppReporterTransfer
    to_multi_app = current_pattern
    from_reporters = 'OptimizationReporter/pattern'
    to_reporters = 'pattern_results/pattern'
  []
  [data]
    type = MultiAppReporterTransfer
    from_multi_app = current_pattern
    from_reporters = 'pattern_results/simulation_values'
    to_reporters = 'OptimizationReporter/temperature'
  []
[]

[Executioner]
  type = Optimize
  solve_on = none
  tao_solver = taonm
  petsc_options_iname = '-tao_gatol'
  petsc_options_value = '1e-2'
  verbose = true
[]

[Outputs]
  [out]
    type = JSON
  []
[]
