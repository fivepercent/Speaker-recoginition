function test(testdir, n, code)
disp(' ');
disp('testing start:')
nc=0;
for k = 1:n                     
    file = sprintf('%ss%d.wav', testdir, k);
    [s, fs] = wavread(file);      
        
    v = mfcc(s, fs);           
   
    distmin = inf;
    k1 = 0;
   
    for l = 1:length(code)      
        d = disteu(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);
      
        if dist < distmin
            distmin = dist;
            k1 = l;
        end
    end
    if(distmin<10)
       msg = sprintf('Speaker %d matches with speaker %d: distortion is %d', k, k1,distmin);
       if(k==k1)
           nc=nc+1;
       end    
    else
       msg = sprintf('Speaker %d does not match with speakers in database: distortion is %d', k, distmin);
    end
    disp(msg);
end
rate=(nc/n)*100;
msg = sprintf('The accuracy of speaker recognition is %0.2d%', rate);
disp(msg);

