function [q, z9,z0, w3,w2] = qfinding(F,q1,q2,w2,c,R2,I,A3,tol)
z0=R2*tand(I)^2/(2*tand(A3));
q8=1;
while q8>tol
q=0.5*(q1+q2);
w3=w2/q;
z9=w3/(c*z0);
if z9>=1
    q9=1-1/(2*z9);
  
elseif z9>=0.4
    q9=0.36*z9+.14;
else 
    q9=(1.195+1.75*z9-z9*z9)^0.5-1.033;
end
  y=q9-q;
  if F==2  
  y9=abs(y);
  q2=1;
  F=1;
  else
  end
  
  y8=y9*y;
  if y8>=0
      y9=y;
      q1=q;
  elseif y8<0
      q2=q;
  end
  q8=abs(q2-q1);

end