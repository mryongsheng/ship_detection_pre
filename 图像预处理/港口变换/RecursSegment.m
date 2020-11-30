 function [lineprm, varargout] = RecursSegment(accum, struct_thres)  
    % 'struct_thres' contains [thres, deltathres, maxthres]  
    % 'lineprm' is in pixel coordinate (w.r.t. 'accum')  
      
      
    % Parameters  
    prm_as_minpixn = 3;  
    prm_as_maxsize = [12, 12];  
      
      
    % Thresholding  
    accummask = ( accum > struct_thres(1) );  
      
      
    % Segmentation and locating the centroids of individual regions  
    [accumlabel, accum_nRgn] = bwlabel( accummask, 8 );  
      
      
    % Segmentation label (for debug purpose)  
    func_seglbl = ( nargout > 1 );  
    if func_seglbl  
        seglbl_lblshft = 4;  
        seglabel = accumlabel;  
    end  
      
      
    lineprm = zeros(0, 2);  
    for k = 1 : accum_nRgn  
        % Linear indices of the pixels in one connected component  
        acmrgn_lin = find( accumlabel == k );  
        if numel(acmrgn_lin) < prm_as_minpixn  
            continue;  
        end  
        % Subscripts of the pixels in one connected component  
        [acmrgn_IdxPho, acmrgn_IdxTheta] = ...  
            ind2sub( size(accumlabel), acmrgn_lin );  
      
      
        % Further segmentation if the connected region is too big, or  
        % computing the centroid of the region  
        % -- Axis-aligned bounding box for the region  
        bndbox = [ min(acmrgn_IdxPho), max(acmrgn_IdxPho), ...  
            min(acmrgn_IdxTheta), max(acmrgn_IdxTheta) ];  
      
      
        % -- Further segmentation  
        bAddCentrdOfRgn = true;  
        if ( (bndbox(2) - bndbox(1) + 1) > prm_as_maxsize(1) || ...  
                (bndbox(4) - bndbox(3) + 1) > prm_as_maxsize(2) ) && ...  
                (struct_thres(1) + struct_thres(2)) <= struct_thres(3)  
            if func_seglbl  
                [lineprm_sub, seglabel_sub] = RecursSegment( ...  
                    accum(bndbox(1):bndbox(2), bndbox(3):bndbox(4)), ...  
                    [struct_thres(1) + struct_thres(2), struct_thres(2:3)] );  
                seglabel(bndbox(1):bndbox(2), bndbox(3):bndbox(4)) = ...  
                    seglabel(bndbox(1):bndbox(2), bndbox(3):bndbox(4)) + ...  
                    seglabel_sub + (seglabel_sub > 0) * seglbl_lblshft;  
            else  
                lineprm_sub = RecursSegment( ...  
                    accum(bndbox(1):bndbox(2), bndbox(3):bndbox(4)), ...  
                    [struct_thres(1) + struct_thres(2), struct_thres(2:3)] );  
            end  
            if ~isempty(lineprm_sub)  
                lineprm = [lineprm; lineprm_sub(:,1) + bndbox(1) - 1, ...  
                    lineprm_sub(:,2) + bndbox(3) - 1 ];  
                bAddCentrdOfRgn = false;  
            end  
        end  
      
      
        % -- Computing the centroid of the whole region  
        if bAddCentrdOfRgn  
            acmrgn_acmsum = sum( accum(acmrgn_lin) );  
            lp_IdxPho = sum( acmrgn_IdxPho .* accum(acmrgn_lin) ) / ...  
                acmrgn_acmsum;  
            lp_IdxTheta = sum( acmrgn_IdxTheta .* accum(acmrgn_lin) ) / ...  
                acmrgn_acmsum;  
            lineprm = [ lineprm; lp_IdxPho, lp_IdxTheta ];  
        end  
    end  
      
      
    % Output the segmentation label  
    if func_seglbl  
        varargout{1} = seglabel;  
    end  
      