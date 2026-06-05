clc
clear
close all

%Task 1
Force = readmatrix("Force.csv");
Elongation = readmatrix("Elongation.csv");
LWH = input("Enter the length, width, and height of the sample as a 1x3 vector [mm]: ");
len = LWH(1);
wid = LWH(2);
high = LWH(3);

A = wid*high;
stress = Force ./ A;
strain = (Elongation ./ len)*100;

figure(1);
plot(strain, stress, "ro", "MarkerFaceColor", "r");
grid on
title("Stress-Strain Tenise Test Results")
xlabel("Strain (\epsilon) [%]")
ylabel("Stress (\sigma) [MPa]")

%Task 2
points = length(strain);
third = points / 3;
strain1 = strain(1:third);
stress1 = stress(1:third);
strain2 = strain(third+1:2*third);
stress2 = stress(third+1:2*third);
strain3 = strain(2*third+1:end);
stress3 = stress(2*third+1:end);

lin = polyfit(strain1, stress1, 1);
pow = polyfit(log10(strain2), log10(stress2), 1);
Exp = polyfit(strain3, log(stress3), 1);
func1 = @(x) polyval(lin, x) - (10^pow(2) * x.^pow(1));
int1 = fzero(func1, strain(third));
func2 = @(x) (10^pow(2) * x.^pow(1)) - (exp(Exp(2)) * exp(Exp(1)*x));
int2 = fzero(func2, strain(2*third));
xLin = linspace(strain(1), int1, 100);
xPow = linspace(int1, int2, 100);
xExp = linspace(int2, strain(end), 100);
yLin = polyval(lin, xLin);
yPow = 10^pow(2) * xPow.^pow(1);
yExp = exp(Exp(2)) * exp(Exp(1) * xExp);

figure(2)
plot(xLin, yLin, "k", "LineWidth", 3); hold on;
plot(xPow, yPow, "k", "LineWidth", 3);
plot(xExp, yExp, "k", "LineWidth", 3);
grid on
title("Stress-Strain Curve for an Unknown Material");
xlabel("Strain (\epsilon) [%]");
ylabel("Stress (\sigma) [MPa]");
axis([0, max(strain)*1.1, 0, max(stress)*1.1]);
%Task 3
m = lin(1); %slope
Offset = @(x) (m * (x - 0.2)) - (10^pow(2) * x.^pow(1));%equation
yield = fzero(Offset, strain(third)); %intersection point
stren = m * (yield - 0.2);%yield strength
%data
yTotal = [yLin, yPow, yExp];
xTotal = [xLin, xPow, xExp];
%tensile strength
[tenStren, tsi] = max(yTotal); 
tenStrain = xTotal(tsi);
%fracture point
fracStress = yTotal(end);
fracStrain = xTotal(end);
%plotting
figure(2); 
hold on;
xOffset = linspace(0.2, yield, 100);
yOffset = m * (xOffset - 0.2);
plot(xOffset, yOffset, "r", "LineWidth", 2);
plot([yield, tenStrain, fracStrain], [stren, tenStren, fracStress], "bd", "MarkerFaceColor", "b");
%text on plot
text(yield, stren, "Yield Strength","VerticalAlignment","top","HorizontalAlignment", "left");
text(tenStrain, tenStren, "Tensile Strength","VerticalAlignment", "bottom", "HorizontalAlignment", "center");
text(fracStrain, fracStress, "Fracture Point", "VerticalAlignment", "top", "HorizontalAlignment", "right");
%prints data 
fprintf("The yield strength of the material is %.2f [MPa] \n", stren);
fprintf("The tensile strength of the material is %.2f [MPa] \n", tenStren);
fprintf("The strain at fracture point of the material is %.2f [%%]", fracStrain);
%Task 4
%prompt user for test
numTest = input("\nEnter the number of test measurements that will be evaluated: ");
resultsCell = {};
for i = 1:numTest
    %stores user inputs
    testPt = input("Enter test measurement #" + num2str(i) + " of the format [%, MPa]: ");
    tStrain = testPt(1);
    tStress = testPt(2);
    %plots users inputs
    plot(tStrain, tStress, "ro", "MarkerFaceColor", "r");
    %determines elastic or plastic (region)
    if tStrain <= yield
        reg = "Elastic";
    else
        reg = "Plastic";
    end
    %determines which equation to use
    if tStrain <= int1
        theoStress = polyval(lin, tStrain);
    elseif tStrain <= int2
        theoStress = 10^pow(2) * tStrain^pow(1);
    else
        theoStress = exp(Exp(2)) * exp(Exp(1) * tStrain);
    end
    %determines nominal or irregular (quality)
    if abs(tStress - theoStress) <= (0.05 * theoStress)
        qual = "Nominal";
    else
        qual = "Irregular";
    end
    % stores all results
    resultsCell{i,1} = tStress;
    resultsCell{i,2} = tStrain;
    resultsCell{i,3} = reg;
    resultsCell{i,4} = qual;
end
%prints table
fprintf("Stress [MPa]  Strain [%%]  Region    Quality\n");
for i = 1:numTest
    fprintf("%-13.2f %-11.2f %-9s %s\n",resultsCell{i,1}, resultsCell{i,2}, resultsCell{i,3}, resultsCell{i,4});
end