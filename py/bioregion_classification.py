import re
import csv
import tqdm
import numpy as np
import pandas as pd


def string_found(string1, string2):
    if re.search(r"\b" + re.escape(string1) + r"\b", string2):
        return True
    return False


# Preprocessing to remove grants which are empty, operating support, etc.
data = pd.read_csv('../Data/AllData - AllData.csv')
preproc_ph = pd.read_csv('../Data/Preprocessing/Preprocessing_Phrases_v5.csv')
preproc_phrases = list(preproc_ph.Phrases)
data = data.drop([ele for ele in data.columns.to_list()
                  if ele not in ['Description']], axis=1)
data = data.dropna().reset_index(drop=True)

for phrase in preproc_phrases[:6]:
    data = data[~data.Description.str.contains(phrase)]

for phrase in preproc_phrases[6:]:
    data = data[data.Description.str.lower() != phrase]

data_sentences = data.Description.values.tolist()
data_sentences = [x.lower() for x in data_sentences]

df_eco = pd.read_csv('../Data/Biogeographic_Realms_Ecoregions.csv')
category_names = list(df_eco)
keywords = []
for idx in range(len(category_names)):
    temp = list(set(df_eco[category_names[idx]].dropna()))
    temp = [x.strip().lower() for x in temp]
    keywords.append(temp)

grant_categories = []
grant_keywords = []

pbar = tqdm.tqdm(total=len(data_sentences))
for grant in data_sentences:
    curr_cat = []
    curr_key = []

    for idx in range(len(category_names)):
        for keyword in keywords[idx]:
            if string_found(keyword, grant):
                curr_key.append(keyword.replace(' ', '_'))
                curr_cat.append(category_names[idx])
    curr_key = list(set(curr_key))
    curr_cat = list(set(curr_cat))
    grant_categories.append(curr_cat)
    grant_keywords.append(curr_key)
    pbar.update(1)
pbar.close()

# Store description, keywords and categories as csv
output_grants = []

pbar = tqdm.tqdm(total=len(data_sentences))
for idx in range(len(data_sentences)):
    temp = []
    temp.append(data_sentences[idx])
    temp.append("|".join(grant_keywords[idx]))
    temp.append("|".join(grant_categories[idx]))
    output_grants.append(temp)
    pbar.update(1)
pbar.close()

with open("../Data/Output/output_bioregions_v8.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(output_grants)
