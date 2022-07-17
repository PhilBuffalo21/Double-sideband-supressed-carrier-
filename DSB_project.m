  clear;
  fc = 1000;
  Fs = fc*10; %Sampling Freq
  t =-0.1:1/Fs:0.1; %Time Vector
  A = 1; % Carrier Amplitude

  m = cos(2*pi*100*t)-1/3*(cos(2*pi*70*t))+1/5*(cos(2*pi*1*t)); 
  c = A*(cos(2*pi*fc*t));
  hf = exp(-2i*pi*5*t)+exp(-2i*pi*30*t);
  
  x = m.*c;
  figure(1)
  subplot(4,1,1);
  plot(t,c)
  figure(1)
  title('Carrier');
  subplot(4,1,2);
  plot(t,m)
  figure(1)
  title('Message')
  subplot(4,1,3);
  plot(t,x);
  title('Modulated signal in Time Domain')
    
  L = length(x);
  NFFT = 2^nextpow2(L);
  x_fft = 2*abs(fft(x,NFFT)/L);
  freq = Fs/2*linspace(0,1,NFFT/2+1);
  figure(1)
  subplot(4,1,4)
  plot(freq,x_fft(1:NFFT/2+1)); 
  title("Modulated signal in Frequency Domain")
  
  xt = x;
  xf = fft(xt);
  yf = xf.*hf;
  yt = ifft(yf);
  figure;
  subplot(2, 1, 1)
  plot(t, hf); 
  grid on; 
  title("H(f)") 
  subplot(2, 1, 2)
  plot(t, yt); 
  grid on; 
  title("y(t)")
    
  carrier = c;
  
  demod = yt.*carrier;
  figure(3);
  subplot(4,1,1);
  plot(t, demod);
  title("Demodulated Signal");
  
  Fs2 = Fs/2;
  [b,a]= butter ( 4, 120 / Fs2 );
  filtered = filter(b,a,demod);
  figure(3)
  subplot(4,1,2)
  plot(t, filtered);
  title("Demodulated Filtered");
  
  L = length(demod);
  NFFT = 2^nextpow2(L);
  xt_fft = 2*abs(fft(demod,NFFT)/L);
  freq = Fs2*linspace(0,1,NFFT/2+1);
  figure(3)
  subplot(4,1,3);
  plot(freq, xt_fft(1:NFFT/2+1));
  title("Fourier of Demodulated Signal");
  
  L = length(filtered);
  NFFT = 2^nextpow2(L);
  f_fft = 2*abs(fft(filtered,NFFT)/L);
  freq = Fs2*linspace(0,1,NFFT/2+1);
  figure(3)
  subplot(4,1,4);
  plot(freq,f_fft(1:NFFT/2+1)); 
  title("Fourier of Filtered Demodulated Signal")
  