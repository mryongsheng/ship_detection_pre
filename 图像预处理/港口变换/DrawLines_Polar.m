 function DrawLines_Polar(imgsize, lineprm, varargin)  
      
    hold on;  
    line = zeros(2,2);  
    for k = 1 : size(lineprm, 1)  
        if lineprm(k,2) > pi/4 && lineprm(k,2) < 3*pi/4  
            line(1,1) = 0;  
            line(1,2) = lineprm(k,1) / sin(lineprm(k,2));  
            line(2,1) = imgsize(2);  
            line(2,2) = line(1,2) - line(2,1) / tan(lineprm(k,2));  
        else  
            line(1,2) = 0;  
            line(1,1) = lineprm(k,1) / cos(lineprm(k,2));  
            line(2,2) = imgsize(1);  
            line(2,1) = line(1,1) - line(2,2) * tan(lineprm(k,2));  
        end  
        % The image origin defined in function '[...] = Hough_Grd(...)' is  
        % different from what is defined in Matlab, off by (0.5, 0.5).  
        line = line + 0.5;  
        % Draw lines using 'plot'  
        if nargin > 2  
            plot(line(:,1), line(:,2), varargin{1});  
        else  
            plot(line(:,1), line(:,2));  
        end  
    end  
    hold off;  

