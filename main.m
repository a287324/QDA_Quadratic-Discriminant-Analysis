clearvars; clc; close all;
format compact;
% 本程式採用LOOCV來評估樣本使用QDA進行分類的可靠性
% 公設
% 1. 類別標籤的起始值從1開始,並且類別標籤必須連號
% 2. 樣本數據的變數名稱為data
% 3. 樣本標籤的變數名稱為label
% 4. 樣本的每個類別的樣本數量必須一致,即第1類別的樣本數量和其他類別的數量都必須一樣
% 5. 樣本的特徵向量為row vector,不是column vector

% 樣本資訊
sample.Path = "dataset/fisheriris.mat"; % 樣本的位置
sample.NC = 3;      % 此樣本的類別數量
sample.NCk = 50;    % 每個類別的樣本數量

% 讀取樣本
load(sample.Path);
N = size(label, 1);
if (sample.NC*sample.NCk) ~= N
    error("樣本資訊與樣本總數量不匹配");
end

% LOOCV(leave-one-out cross-validation)
Nerror = 0; % 紀錄錯誤數量
resultError = zeros(N, 3);  % 紀錄錯誤的報告
for n = 1:N
    % 從樣本抽取一個當測試樣本,其餘當訓練樣本
    Stest.data = data(n, :);
    Stest.info = label(n);
    Strain.data = data;     Strain.data(n,:) = [];
    Strain.info = label;     Strain.info(n) = [];
    % 建模(QDA)
    QDA = QDA_model(Strain);
    % 測試模型(QDA)
    C = QDA_test(QDA, Stest);
    % 檢查分類結果
    if Stest.info ~= C
        Nerror = Nerror + 1;
        resultError(Nerror,:) = [n, Stest.info, C];
    end
end
% 顯示結果
fprintf("正確率：%5.2f%%\n", (1-Nerror/N)*100);
fprintf("錯誤個數為: %d\n", Nerror);
fprintf("錯誤發生：\n");
fprintf("      %6s %6s %5s\n", "測試樣本編號", "測試樣本類別", "判斷的類別");
for n = 1:Nerror
    fprintf("%5s %12d %12d %10d\n", ["(" + num2str(n) + ")"], resultError(n, 1), resultError(n, 2), resultError(n, 3));
end