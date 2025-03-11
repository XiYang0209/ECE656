import pandas as pd

# 读取数据集
columns = ["age", "workclass", "fnlwgt", "education", "education-num", "marital-status", 
           "occupation", "relationship", "race", "sex", "capital-gain", "capital-loss", 
           "hours-per-week", "native-country", "income"]

# 读取 adult.data 和 adult.test
train_data = pd.read_csv("./Lab4/adult.data", names=columns, sep=",\s*", engine="python")
test_data = pd.read_csv("./Lab4/adult.test", names=columns, skiprows=1, sep=",\s*", engine="python")

# 统计每个类别的数量
train_class_counts = train_data["income"].value_counts()
test_class_counts = test_data["income"].value_counts()

# 计算每个类别的比例
train_class_proportions = train_class_counts / train_class_counts.sum()
test_class_proportions = test_class_counts / test_class_counts.sum()

# 输出结果
print("Training Data Class Distribution:")
print(train_class_counts)
print("\nPercentage:")
print(train_class_proportions)

print("\nTesting Data Class Distribution:")
print(test_class_counts)
print("\nPercentage:")
print(test_class_proportions)
