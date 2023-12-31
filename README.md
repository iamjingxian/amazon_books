# amazon_books
database of book reviews from multiple platforms

dataset sources (note: >20Gb combined, require decent RAM and processor)
- Amazon [ratings](https://jmcauley.ucsd.edu/data/amazon_v2/categoryFilesSmall/Books_5.json.gz) and [meta data](https://forms.gle/UEkkJs69e7Z5A5Ps9) available at [Amazon Review Data, (2018)](https://nijianmo.github.io/amazon/index.html);
- goodreads [reviews](https://drive.google.com/uc?id=1pQnXa7DWLdeUpvUFsKusYzwbA5CAAZx7) and book [information](https://drive.google.com/uc?id=1LXpK1UfqtP89H1tYy0pBGHjYk8IhigUK) available at [UCSD Book Graph](https://sites.google.com/eng.ucsd.edu/ucsdbookgraph/home);
- artificially generated reviewes were based on a smaller (older) [Kaggle](https://www.kaggle.com/datasets/mohamedbakhet/amazon-books-reviews) [dataset](https://www.kaggle.com/datasets/mohamedbakhet/amazon-books-reviews/download?datasetVersionNumber=1) and are available for download [here](https://drive.google.com/file/d/1stjQF2rrGWtqjClWZdzMNEIVE3s_wCIk/view?usp=drive_link). 

scripts
- run notebook to unpack data files, and generate csv files for individual relations tables to be loaded into an RDMS (in our case, MySQL)
- run sql in MySQL workbench to load relation tables
- run scipt to convert strings in json to array, to be imported to MongoDB.
- run sample queries per script. see link to [video demo of queries](https://drive.google.com/drive/folders/12ji0QyLGWv9pNM24RzIrL_OY-6UdUQEY?usp=sharing) 

References<br>
- amazon dataset. Jianmo Ni, Jiacheng Li, Julian McAuley, Empirical Methods in Natural Language Processing (EMNLP), 2019
- goodreads dataset. Mengting Wan, Julian McAuley, "Item Recommendation on Monotonic Behavior Chains", in RecSys'18. [bibtext](https://dblp.uni-trier.de/rec/bibtex/conf/recsys/WanM18)
- goodreads dataset. Mengting Wan, Rishabh Misra, Ndapa Nakashole, Julian McAuley, "Fine-Grained Spoiler Detection from Large-Scale Review Corpora", in ACL'19. [bibtext](https://dblp.uni-trier.de/rec/bibtex/conf/acl/WanMNM19)
- script to artificailly generate reviews were adapted from [Paraphrase-generator](https://github.com/Vamsi995/Paraphrase-Generator#)
