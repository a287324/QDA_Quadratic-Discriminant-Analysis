function C = QDA_test(QDA, Stest)
    NC = size(QDA.pi, 1);  % 類別總數量
    delta = zeros(NC, 1);
    x = Stest.data;
    for n = 1:NC
        delta(n) = -0.5*log(det(QDA.Sigma{n}))-0.5*(x-QDA.mu{n})*inv(QDA.Sigma{n})*((x-QDA.mu{n}).')+log(QDA.pi{n});
    end
    [~, C] = max(delta);
end