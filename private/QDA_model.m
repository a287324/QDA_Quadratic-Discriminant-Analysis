% 公設
% 1. 類別標籤的起始值從1開始,並且類別標籤必須連號
% 2. 訓練資料必須是結構體,且該結構體的成員變數為樣本資料(data)和樣本資訊(info)

function QDA = QDA_model(Strain)
    N = size(Strain.info, 1);   % 樣本總數量
    NC = max(Strain.info);  % 類別總數量
    QDA.mu = cell(3,1);
    QDA.Sigma = cell(3,1);
    QDA.pi = cell(3,1);
    for n = 1:NC
        % 取出類別資料
        data = Strain.data((Strain.info == n), :);
        % 計算QDA的模型參數(類別的平均值,共變異數矩陣,先驗機率)
        QDA.mu{n} = mean(data);
        QDA.Sigma{n} = cov(data);
        QDA.pi{n} = size(data, 1)/N;
    end
end