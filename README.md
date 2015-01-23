# GettingAndCleaningDataProject

### 摘要
本文是针对Getting and Cleaning Data课程项目的说明文档，介绍了run_analysis.R 文件中的处理过程。


### run_analysis.R 处理过程
#### 1. 基本数据集初始化阶段：
首先初始化两个data frame: features 和 activities，方便后面使用，在activities 中，还要改掉不同活动的列名，以便于用在结果的 data frame 中；同时，还要将 activities 中的 activity 列因子化，以便于结果数据集与其做 join，取得 activity name。

#### 2. test 数据集读取和基本处理阶段：
读取 X_test 数据集后，使用 features 数据集重新命名得到的数据集中对应列（变量），这些列为561个 features 对应的列；然后读取y_test 和 subject_test，将其与读取 X_test 数据集后得到的data frame 横向合并，也就是得到test 数据集中每个 subjec 每个activity 对应的561个观测值。

#### 3. train 数据集读取和基本处理阶段：
与2中逻辑相同。

#### 4. 纵向合并 test 和 train 数据集：
得到满足项目要求1中的数据集 all_data。

#### 5. 筛选平均值以及标准差数据集
先将 all_data 中的 subject 和 activity 因子化，然后选出 features 中与平均值和标准差相关的 feature 名称数据集，并使用该数据集将 all_data 数据集做 melting 操作。此时得到满足项目要求2的数据集 rd。

#### 6. 使用描述性活动名称命名数据集中的活动
以 activity 列为 ID，将基本数据集 activities 与 rd 做 join，既可以得到每行数据中各个 activity 对应的描述名称，去掉 activity 列，即得到满足项目3的数据集。

#### 7. 重新命名 melting 得到的两列名称
同时，调换各列顺序，得到满足项目要求4的数据集。

#### 8. 创建包含平均值的整洁数据集并输出
使用 dcast 可以完成平均值计算，然后使用 write.table 输出数据，就得到了满足项目要求5的数据集文件。
