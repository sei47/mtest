#Userモデル
|  カラム  |  type  |
| ---- | ---- |
|  name  | string  |
|  email  |  string  |
|  password_digest  |  string  |

#Task
|  カラム  |  type  |
| ---- | ---- |
|  name  | string  |
|  content  |  text  |
|  deadline  |  string  |
|  priority  |  string  |
|  status  |  string  |

#Label
  |  カラム  |  type  |
  | ---- | ---- |
  |  type  | string  |

## ヘロクのタスクデプロイ方法
 git push heroku step2:masterをターミナルに打ち込んでデプロイする
