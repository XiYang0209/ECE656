from sklearn.metrics import accuracy_score, f1_score
import pandas as pd

# 读取数据集
columns = ["age", "workclass", "fnlwgt", "education", "education-num", "marital-status", 
           "occupation", "relationship", "race", "sex", "capital-gain", "capital-loss", 
           "hours-per-week", "native-country", "income"]

# 读取 adult.test
test_data = pd.read_csv("./Lab4/adult.test", names=columns, skiprows=1, sep=",\s*", engine="python")

# 真实标签（假设是从 adult.test 计算得到）
y_true = test_data["income"].str.strip().str.replace(".", "", regex=False)
print(y_true.unique())  # 确保现在只有 ['<=50K', '>50K']


# 无脑分类器：全部预测为 '<=50K'
y_pred = ["<=50K"] * len(y_true)

# 计算 Accuracy 和 F1-score
accuracy = accuracy_score(y_true, y_pred)
f1 = f1_score(y_true, y_pred, pos_label="<=50K")  # 指定低收入为正例

print(f"Trivial Classifier Accuracy: {accuracy:.4f}")
print(f"Trivial Classifier F1-score: {f1:.4f}")
