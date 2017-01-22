function [ Fx, Fy, Fz ] = calculate_viscous_force_team216( vel, waterViscousCoeff )
%calculate_viscous_force_team216 Compute visous force

    Fx = -vel(1)*waterViscousCoeff;
    Fy = -vel(2)*waterViscousCoeff;
    Fz = -vel(3)*waterViscousCoeff;

end

