import pandas as pd
import numpy as np
import math
import tqdm

from sklearn.preprocessing import MultiLabelBinarizer
mlb = MultiLabelBinarizer()
data = pd.read_csv('../Data/AllData - AllData.csv')
preproc_ph = pd.read_csv('../Data/Preprocessing/Preprocessing_Phrases_v5.csv')

preproc_phrases = list(preproc_ph.Phrases)
data = data.drop([ele for ele in data.columns.to_list() if ele in ['X', 'Random Sort', 'Unnamed: 0']], axis=1)
data = data.dropna(subset=['Description'])

for phrase in preproc_phrases[:6]:
    data = data[~data.Description.str.contains(phrase)]

for phrase in preproc_phrases[6:]:
    data = data[data.Description.str.lower() != phrase]

data = data.reset_index(drop=True)
data_class = pd.read_csv('../Data/Output/Master Output/v15/master_output_v15.csv')
data_class = data_class.fillna('-')

pbar = tqdm.tqdm(total=len(data))
for idx in range(len(data)):
    for col in data_class.columns[1:]:
        if type(data_class[col][idx]) == str:
            data_class[col][idx] = list(set(data_class[col][idx].split('|')))
    pbar.update(1)
pbar.close()
df_final = pd.concat([data, data_class[['Keywords', 'Filtered_Categories',
                                        'Bio_keywords', 'Bio_regions']]],
                     axis=1)
df_final = df_final.join(pd.DataFrame(mlb.fit_transform(df_final.pop('Filtered_Categories')),columns=['cat_' + x for x in mlb.classes_],index=df_final.index))
df_final = df_final.join(pd.DataFrame(mlb.fit_transform(df_final.pop('Bio_keywords')),columns=['bio_key_' + x for x in mlb.classes_],index=df_final.index))
df_final = df_final.join(pd.DataFrame(mlb.fit_transform(df_final.pop('Bio_regions')),columns=['bio_reg_' + x for x in mlb.classes_],index=df_final.index))

df_final = df_final.drop(['cat_-', 'bio_key_-', 'bio_reg_-'], axis=1)
df_final.to_csv('../Data/Output/Master Output/v15/master_output_data_analysis_v15.csv', index=False)
