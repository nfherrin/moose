## Units in the input file: m-Pa-s-K-V

[Mesh]
  [pattern]
    type =  CartesianMeshGenerator
    dim = 2
    dx = '1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0'
    dy = '1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0'
    ix = '1 1 1 1 1 1 1 1 1 1'
    iy = '1 1 1 1 1 1 1 1 1 1'
    subdomain_id = '1 1 1 1 1 1 1 1 2 2
                    1 1 1 1 1 1 2 2 2 1
                    1 1 1 1 1 2 2 1 1 1
                    1 1 1 1 1 2 1 1 1 1
                    1 1 1 1 1 2 1 1 1 1
                    1 1 1 1 2 2 1 1 1 1
                    1 1 1 2 2 1 1 1 1 1
                    1 1 2 2 1 1 1 1 1 1
                    1 2 2 1 1 1 1 1 1 1
                    2 2 1 1 1 1 1 1 1 1'
  []
[]

[Variables]

  [temperature]
  []

[] # Variables

[Kernels]

  [heat_conduction]
    type = HeatConduction
    variable = temperature
  []

[] # Kernels

[Materials]

  [./heat1]
    type = HeatConductionMaterial
    block = 1
    thermal_conductivity = 1
  [../]

  [./heat2]
    type = HeatConductionMaterial
    block = 2
    thermal_conductivity = 1000
  [../]

[] # Materials

[BCs]
  [t_left]
    type = DirichletBC
    variable = temperature
    value = 300
    boundary = 'left'
  []
  [t_right]
    type = DirichletBC
    variable = temperature
    value = 200
    boundary = 'right'
  []
[]

[Executioner]

  type = Steady

  nl_rel_tol = 1e-15
  nl_max_its = 20000

  l_abs_tol = 1e-15
  l_max_its = 20000

[] # Executioner

[Reporters]
  [pattern_results]
    type = OptimizationData
    file_xcoord = x
    file_ycoord = y
    file_value = temperature
    variable = temperature
    execute_on = final
    outputs = csv
  []
[]

[Outputs]
  exodus = true
[] # Outputs
