# Depression-detection-wavelet-synchrosqueezed-transform

This MATLAB code processes EEG (electroencephalogram) data from two different classes ('h (healthy)' and 'mdd' (major depressive disorder), normalizes the signals, segments them into 30-second chunks, and generates wavelet scalograms for each segment. Below is a detailed breakdown of its functionality:
1. Channel Setup
channels: A cell array containing 19 EEG channel names (e.g., 'fp1', 'f3', etc.).
selected_rows = 1:19: Indices of the channels to process (all 19 channels are selected by default).

2. Sampling and Segment Length
Fs = 128: Sampling rate (128 Hz).
sl = 30 * Fs: Defines a segment length of 30 seconds (3840 samples).
sl = floor(sl): Ensures the segment length is an integer.

3. Class Directories
class_dirs = {'h', 'mdd'}: Two classes of EEG data:
'h' ("healthy" ).
'mdd'  ("major depressive disorder").

4. Processing Loop
For each class ('h' and 'mdd'):
a. Load .mat Files
Lists all .mat files in the class directory.
For each file:
Loads the EEG data (stored as a variable inside the .mat file).
Extracts the variable name dynamically (varName = fields(fileVar)).
Retrieves the data matrix (data_matrix = fileVar.(varName{1})).
b. Channel-wise Processing
For each selected EEG channel:
Extract & Normalize:
Extracts the EEG signal for the channel (channel_data = data_matrix(ch, :)).
Applies z-score normalization (normalize(..., 'zscore')).
Segmentation:
Divides the signal into 30-second segments (sl samples each).
Stores segments in a matrix (segments).
WSST Generation:
For each segment:
Computes the Wavelet Synchrosqueezed Transform (WSST) (wsst(x, 'bump')).
Plots the absolute values of the transform as an image (scalogram).
Hides the figure ('Visible', 'off') to avoid display overhead.

Saves the scalogram as an image (currently commented out: saveas(...)).
Closes the figure (close(h)).
Cleanup:
Clears temporary variables (channel_data, segments) to free memory.
