import tqdm
import pandas as pd
import numpy as np

data_class = pd.read_csv('output_grants_v15_filtered.csv')
data_bio = pd.read_csv('output_bioregions_v8.csv')

df_final = pd.concat([data_class, data_bio[['Bio_keywords', 'Bio_regions']]],
                     axis=1)
df_backup = df_final.copy()
df_final = df_final.fillna('-')
df_final.to_csv('./Master Output/v15/master_output_v15.csv', index=False)
