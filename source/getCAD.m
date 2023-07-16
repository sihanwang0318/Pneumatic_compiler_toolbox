function getCAD(result, short_signalset, space,not_num, and_num, or_num, stl_name_str, mph_name_str)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%% Pre-computing
gateset = getGateset(result,not_num, and_num, or_num);
[lineset, terminal] = getLineset(short_signalset, gateset,not_num, and_num, or_num);
[layer, layerNo] = getLayer(lineset);
layer = max(layer)-layer + 1;
%% Comsol CAD Model Preset

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Sihan\OneDrive - Nexus365\Sihan\Robosoft2023\LL');

model.component.create('comp1', true);
model.component('comp1').geom.create('geom1', 3);
model.component('comp1').mesh.create('mesh1');
model.component('comp1').geom('geom1').lengthUnit('mm');
model.component('comp1').geom('geom1').geomRep('comsol');


%% Build base block accoridng to workspace

layer1_block_set = {};
n = 1;
for i = 1:height(space)
    for j = 1:width(space)
        if space(i,j) == 1
            if i == 3 && j == 3
                model.component('comp1').geom('geom1').create(append('1blk',num2str(n)), 'Block');
                model.component('comp1').geom('geom1').feature(append('1blk',num2str(n))).set('size', {num2str(27) num2str(27) num2str(1)});
                model.component('comp1').geom('geom1').feature(append('1blk',num2str(n))).set('pos', {num2str(24*(i-1)-3) num2str(24*(j-1)-3) num2str(0)});
                layer1_block_set = [layer1_block_set append('1blk',num2str(n))];
                n = n+1;
            elseif i == 4 && j == 1
                model.component('comp1').geom('geom1').create(append('1blk',num2str(n)), 'Block');
                model.component('comp1').geom('geom1').feature(append('1blk',num2str(n))).set('size', {num2str(26) num2str(24) num2str(1)});
                model.component('comp1').geom('geom1').feature(append('1blk',num2str(n))).set('pos', {num2str(24*(i-1)-2) num2str(24*(j-1)) num2str(0)});
                layer1_block_set = [layer1_block_set append('1blk',num2str(n))];
                n = n+1;
            else            
                model.component('comp1').geom('geom1').create(append('1blk',num2str(n)), 'Block');
                model.component('comp1').geom('geom1').feature(append('1blk',num2str(n))).set('size', {num2str(24) num2str(24) num2str(1)});
                model.component('comp1').geom('geom1').feature(append('1blk',num2str(n))).set('pos', {num2str(24*(i-1)) num2str(24*(j-1)) num2str(0)});
                layer1_block_set = [layer1_block_set append('1blk',num2str(n))];
                n = n+1;
            end
        end
    end
end
model.component('comp1').geom('geom1').create('1LayerBlock', 'Union');
model.component('comp1').geom('geom1').feature('1LayerBlock').selection('input').set(layer1_block_set);

%% Drill terminal ports from the base block

n = 1;
terminal_set = {};
for i = 1:height(terminal)
    model.component('comp1').geom('geom1').create(append('terminal',num2str(n)), 'Cylinder');
    model.component('comp1').geom('geom1').feature(append('terminal',num2str(n))).set('pos', {num2str(24*(terminal(i,2)-0.5)) num2str(24*(terminal(i,1)-0.5)) '0'});
    model.component('comp1').geom('geom1').feature(append('terminal',num2str(n))).set('r', num2str(1.4));
    model.component('comp1').geom('geom1').feature(append('terminal',num2str(n))).set('h', num2str(1));
    terminal_set = [terminal_set append('terminal',num2str(n))];
    n = n+1;
end

model.component('comp1').geom('geom1').create('1Layer', 'Difference');
model.component('comp1').geom('geom1').feature('1Layer').selection('input').set({'1LayerBlock'});
model.component('comp1').geom('geom1').feature('1Layer').selection('input2').set(terminal_set);

%% Build 2nd layer block accoridng to workspace
for layer_no = 2:max(layer)+1
    layer2_block_set = {};
    n = 1;
    if layer_no == max(layer) + 1
        HHH = 3.5;
    else
        HHH = 3;
    end
    for i = 1:height(space)
        for j = 1:width(space)
            if space(i,j) == 1
                if i ==3 && j == 3
                    model.component('comp1').geom('geom1').create(append(num2str(layer_no),'blk',num2str(n)), 'Block');
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'blk',num2str(n))).set('size', {num2str(27) num2str(27) num2str(HHH)});
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'blk',num2str(n))).set('pos', {num2str(24*(i-1)-3) num2str(24*(j-1)-3) num2str(-5+3*layer_no)});
                    layer2_block_set = [layer2_block_set append(num2str(layer_no),'blk',num2str(n))];
                    n = n+1;
                elseif i == 4 && j == 1
                    model.component('comp1').geom('geom1').create(append(num2str(layer_no),'blk',num2str(n)), 'Block');
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'blk',num2str(n))).set('size', {num2str(26) num2str(24) num2str(HHH)});
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'blk',num2str(n))).set('pos', {num2str(24*(i-1)-2) num2str(24*(j-1)) num2str(-5+3*layer_no)});
                    layer2_block_set = [layer2_block_set append(num2str(layer_no),'blk',num2str(n))];
                    n = n+1;
                else
                    model.component('comp1').geom('geom1').create(append(num2str(layer_no),'blk',num2str(n)), 'Block');
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'blk',num2str(n))).set('size', {num2str(24) num2str(24) num2str(HHH)});
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'blk',num2str(n))).set('pos', {num2str(24*(i-1)) num2str(24*(j-1)) num2str(-5+3*layer_no)});
                    layer2_block_set = [layer2_block_set append(num2str(layer_no),'blk',num2str(n))];
                    n = n+1;
                end
            end
        end
    end
    model.component('comp1').geom('geom1').create(append(num2str(layer_no),'LayerBlock'), 'Union');
    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'LayerBlock')).selection('input').set(layer2_block_set);
    
    %% Drill channels and holes from 2nd layer block
    n = 1;
    hole2_set = {};
    for i = 1:height(gateset)
        for j = 6:2:10
            if ~isnan(gateset(i,j))
                    model.component('comp1').geom('geom1').create(append(num2str(layer_no),'cyl',num2str(n)), 'Cylinder');
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'cyl',num2str(n))).set('pos', {num2str(24*(gateset(i,j+1)-0.5)) num2str(24*(gateset(i,j)-0.5)) num2str(-5+3*layer_no)});
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'cyl',num2str(n))).set('r', num2str(1.4));
                    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'cyl',num2str(n))).set('h', num2str(HHH));
                    hole2_set = [hole2_set append(num2str(layer_no),'cyl',num2str(n))];
                    n = n+1;
            end
        end
    end
    
    
    
    n = 1;
    channel2_set = {};
    for i = 1:height(lineset)
        if layer(i) ~= layer_no - 1
            continue
        end
        model.component('comp1').geom('geom1').create(append(num2str(layer_no),'channel',num2str(n)), 'Block');
        model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'channel',num2str(n))).set('pos', {num2str(24*0.5*(lineset(i,2)-0.5+lineset(i,4)-0.5)) num2str(24*0.5*(lineset(i,1)-0.5+lineset(i,3)-0.5)) num2str(-4+3*layer_no)});
        model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'channel',num2str(n))).set('rot', num2str(180/pi*atan2(lineset(i,3)-lineset(i,1),lineset(i,4)-lineset(i,2))));
        model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'channel',num2str(n))).set('axis', [0 0 1]);
        model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'channel',num2str(n))).set('base', 'center');
        model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'channel',num2str(n))).set('size', {num2str(24*sqrt((lineset(i,4)-lineset(i,2))^2 + (lineset(i,3)-lineset(i,1))^2)) '2.7' '2'});
        channel2_set = [channel2_set append(num2str(layer_no),'channel',num2str(n))];
        n=n+1;
    end
    
    model.component('comp1').geom('geom1').create(append(num2str(layer_no),'Layer'), 'Difference');
    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'Layer')).selection('input').set({append(num2str(layer_no),'LayerBlock')});
    model.component('comp1').geom('geom1').feature(append(num2str(layer_no),'Layer')).selection('input2').set([hole2_set, channel2_set]);
end
% model.component('comp1').geom('geom1').create('blk1', 'Block');
% model.component('comp1').geom('geom1').feature('blk1').set('size', {'width' 'depth' 'height'});
% model.component('comp1').geom('geom1').create('cyl1', 'Cylinder');
% model.component('comp1').geom('geom1').feature('cyl1').set('pos', {'x1' 'y1' '0'});
% model.component('comp1').geom('geom1').feature('cyl1').set('r', 'R');
% model.component('comp1').geom('geom1').feature('cyl1').set('h', 'height');
% model.component('comp1').geom('geom1').create('cyl2', 'Cylinder');
% model.component('comp1').geom('geom1').feature('cyl2').set('pos', {'x2' 'y2' '0'});
% model.component('comp1').geom('geom1').feature('cyl2').set('r', 'R');
% model.component('comp1').geom('geom1').feature('cyl2').set('h', 'height');
% model.component('comp1').geom('geom1').create('cyl3', 'Cylinder');
% model.component('comp1').geom('geom1').feature('cyl3').set('pos', {'x3' 'y3' '0'});
% model.component('comp1').geom('geom1').feature('cyl3').set('r', 'R');
% model.component('comp1').geom('geom1').feature('cyl3').set('h', 'height');
% model.component('comp1').geom('geom1').create('blk2', 'Block');
% model.component('comp1').geom('geom1').feature('blk2').set('pos', {'(x2+x3)/2' '(y2+y3)/2' 'height/2'});
% model.component('comp1').geom('geom1').feature('blk2').set('rot', 'atan2((y3-y2),(x3-x2))/pi*180');
% model.component('comp1').geom('geom1').feature('blk2').set('axis', [0 0 1]);
% model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
% model.component('comp1').geom('geom1').feature('blk2').set('size', {'sqrt((x2-x3)^2+(y2-y3)^2)' '2*R' 'height'});
% model.component('comp1').geom('geom1').create('dif1', 'Difference');
% model.component('comp1').geom('geom1').feature('dif1').selection('input').set({'blk1'});
% model.component('comp1').geom('geom1').feature('dif1').selection('input2').set({'blk2' 'cyl1' 'cyl2' 'cyl3'});
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').physics.create('solid', 'SolidMechanics', 'geom1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.component('comp1').geom('geom1').export(stl_name_str);
model.save(mph_name_str)
% model.component('comp1').geom('geom1').export('C:\Users\Sihan\OneDrive - Nexus365\Sihan\Robosoft2023\LL\sihan_CAD.stl');
% model.save('C:\Users\Sihan\OneDrive - Nexus365\Sihan\Robosoft2023\LL\compiler1')
end