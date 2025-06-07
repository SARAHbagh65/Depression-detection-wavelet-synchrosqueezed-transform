% Array of channel names
channels = {'fp1','f3','c3','p3','o1','f7','t3','t5','fz','fp2','f4','c4','p4','o2','f8','t4','t6','cz','pz'};

% Selected row indices
selected_rows = 1:19; % adjust this according to your needs
Fs = 128;
sl = 30 * Fs;
sl = floor(sl);

% Define directories for classes
class_dirs = {'h', 'mdd'};

for em = 1:length(class_dirs)
    class = class_dirs{em};
    
    % List all .mat files in the directory
    files = dir(sprintf('%s/*.mat', class));
    
    for fi = 1:numel(files)
        % Load the .mat file for this subject from the current class directory
        filename = fullfile(class, files(fi).name);
        fileVar = load(filename);  % Load the .mat file
        varName = fields(fileVar);  % Get the variable name
        data_matrix = fileVar.(varName{1});  % Get the variable data

        for i = 1:length(selected_rows)  % iterate only over the selected channels
            ch = selected_rows(i);
            channel_name = channels{ch};
            
            % Extract the EEG data for this channel and normalize
            channel_data = data_ematrix(ch, :);
            channel_data = normalize(channel_data,'zscore');

            % Segment the normalized channel data into 10-second chunks
            [m,n] = size(channel_data);
            nos = floor(n / sl);
            segments = zeros(nos, sl);

            for ii = 1:nos
                segments(ii,:) = channel_data(((ii-1)*sl)+1 : ii*sl); 
            end 

            % Generate and save a scalogram for each segment
            for jj = 1:nos
                h = figure('Visible', 'off');  % prevent the figure from being displayed
                x = segments(jj,:);
                sstb = wsst(x,'bump');
                imagesc(abs(sstb))
                axis off;
              
                % Save the figure
              
                %saveas(h, sprintf('%s_sw_bu_%s_%02d.jpg', class, channel_name, jj));

                close(h);
            end
            
            % Clear variables that are not needed anymore
            clear channel_data segments
        end
    end
end
