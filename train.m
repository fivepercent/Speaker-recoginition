function code = train(traindir, n)


k = 16;                        
disp('Training start:');
for i = 1:n                     
    file = sprintf('%ss%d.wav', traindir, i); 
    msg = sprintf('Speaker %d training is finished', i);
    disp(msg);
   
    [s, fs] = wavread(file);
    
    v = mfcc(s, fs);            
   
    code{i} = vqlbg(v, k);      
end
