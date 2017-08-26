function M3 = FrameBlocking(s, fs, m, n)
    l = length(s);
    FrameNumber = floor((l - n) / m) + 1;
    
    for i = 1:n
        for j = 1:FrameNumber
            M(i, j) = s(((j - 1) * m) + i);
        end
    end
    
    h = hamming(n);
    M2 = diag(h) * M;
    
    for i = 1:FrameNumber
        M3(:, i) = fft(M2(:, i));
    end
    