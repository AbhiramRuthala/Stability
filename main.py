import mne 
import matplotlib.pyplot as plt
from mne.viz import plot_alignment, set_3d_view

data_path = mne.datasets.sample.data_path()
subjects_dir = data_path / "MEG" / "Subjects" 

bird_fname = data_path / "MEG" / "Sample" 
new_path = data_path / "MEG" / 'Sample' / "sample_audvis_raw.fif"
newgang = mne.read_trans(bird_fname / "sample_audvis_raw-trans.fif")
new_file = mne.io.read_raw_fif(new_path, preload=True)

fig = plot_alignment(
    new_file.info,
#    trans,
    subject="sample",
    dig=False,
    eeg=["original", "projected"],
    meg=[],
    coord_frame="head",
    subjects_dir=subjects_dir,
)

set_3d_view(figure=fig, azimuth=130, elevation=80)
plt.show()
