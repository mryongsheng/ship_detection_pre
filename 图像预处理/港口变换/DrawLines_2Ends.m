function DrawLines_2Ends(lineseg, varargin)  
      
    hold on;  
    for k = 1 : size(lineseg, 1)  
        % The image origin defined in function '[...] = Hough_Grd(...)' is  
        % different from what is defined in Matlab, off by (0.5, 0.5).  
        if nargin > 1  
            plot(lineseg(k,1:2)+0.5, lineseg(k,3:4)+0.5, varargin{1});  
        else  
            plot(lineseg(k,1:2)+0.5, lineseg(k,3:4)+0.5, 'LineWidth', 2);
           % distance=
        end  
    end  
    hold off;  
      