

lung_cancer_risk=function(age, sex,smoking,pneumonia,asbestos,malignant_tumour,family_history){
Male=1;
Female=2;
No=0;
Yes=1;	
	
	
  if(sex==Male){ #male
    if(age>=40& age<=44){a=-9.06}
    else if(age>=45& age<=49){a=-8.16}
    else if(age>=50& age<=54){a=-7.31}
    else if(age>=55& age<=59){a=-6.63}
    else if(age>=60& age<=64){a=-5.97}
    else if(age>=65& age<=69){a=-5.56}
    else if(age>=70& age<=74){a=-5.31}
    else if(age>=75& age<=79){a=-4.83}
    else if(age>=80& age<=84){a=-4.68}
  }
  else if(sex==Female){ # female
    if(age>=40& age<=44){a=-9.90}
    else if(age>=45& age<=49){a=-8.06}
    else if(age>=50& age<=54){a=-7.46}
    else if(age>=55& age<=59){a=-6.50}
    else if(age>=60& age<=64){a=-6.22}
    else if(age>=65& age<=69){a=-5.99}
    else if(age>=70& age<=74){a=-5.49}
    else if(age>=75& age<=79){a=-5.23}
    else if(age>=80& age<=84){a=-5.42}
  }
  
  
  if(smoking==0){b1=0}
  else if(smoking>=1&smoking<=20){b1=0.769}
  else if(smoking>=21&smoking<=40){b1=1.452}
  else if(smoking>=41&smoking<=60){b1=2.507}
  else if(smoking>60){b1=2.724}
  
  
  if(pneumonia==No){b2=0} # no
  else if(pneumonia==Yes){b2=0.602} #yes
  
  if(asbestos==No){b3=0} # no
  else if(asbestos==Yes){b3=0.634} # yes
  
  if(malignant_tumour==No) {b4=0}
  else if(malignant_tumour==Yes){b4=0.675}
  
  if(family_history==0){b5=0}
  else if(family_history<60){b5=0.703}
  else if (family_history>=60){b5=0.168}
  
  risk=1/(1+exp(-(a+b1+b2+b3+b4+b5)))*100
  return(risk)
}

lung_cancer_risk(65,2,37,1,0,0,70)
## 2.257673

