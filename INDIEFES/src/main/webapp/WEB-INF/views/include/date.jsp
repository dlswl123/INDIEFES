<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
function dateSelect(docForm,selectIndex) {
	watch = new Date(docForm.year.options[docForm.year.selectedIndex].text, docForm.month.options[docForm.month.selectedIndex].value,1);
	hourDiffer = watch - 86400000;
	calendar = new Date(hourDiffer);

	var daysInMonth = calendar.getDate();
		for (var i = 0; i < docForm.day.length; i++) {
			docForm.day.options[0] = null;
		}
		for (var i = 0; i < daysInMonth; i++) {
			docForm.day.options[i] = new Option(i+1);
	}
	document.form1.day.options[0].selected = true;
}
</script>

<script>
function Today(year,mon,day){
     if(year == "null" && mon == "null" && day == "null"){       
     today = new Date();
     this_year=today.getFullYear();
     this_month=today.getMonth();
     this_month+=1;
     if(this_month <10) this_month="0" + this_month;
 
     this_day=today.getDate();
     if(this_day<10) this_day="0" + this_day;     
 }
 else{  
     var this_year = eval(year);
     var this_month = eval(mon); 
     var this_day = eval(day);
     }
 
  montharray=new Array(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); 
  maxdays = montharray[this_month-1]; 
//아래는 윤달을 구하는 것
  if (this_month==2) { 
      if ((this_year%4)!=0) maxdays=28; 
      else maxdays=29; 
  } 
 
 document.writeln("<select name='year' size=1 onChange='dateSelect(this.form,this.form.month.selectedIndex);'>");
     for(i=this_year;i>=this_year-150;i--){//현재 년도에서 과거로 150년까지
         if(i==this_year) document.writeln("<OPTION VALUE="+i+ " selected >" +i); 
         else document.writeln("<OPTION VALUE="+i+ ">" +i); 
     }    
 document.writeln("</select>년");      

 
 document.writeln("<select name='month' size=1 onChange='dateSelect(this.form,this.selectedIndex);'>");
     for(i=1;i<=12;i++){ 
         if(i<10){
             if(i==this_month) document.writeln("<OPTION VALUE=0" +i+ " selected >0"+i); 
             else document.writeln("<OPTION VALUE=0" +i+ ">0"+i);
         }         
         else{
             if(i==this_month) document.writeln("<OPTION VALUE=" +i+ " selected >" +i);  
             else document.writeln("<OPTION VALUE=" +i+ ">" +i);  
         }                     
    }         
 document.writeln("</select>월");
 
 document.writeln("<select name='day' size=1>");
     for(i=1;i<=maxdays;i++){ 
         if(i<10){
             if(i==this_day) document.writeln("<OPTION VALUE=0" +i+ " selected >0"+i); 
             else document.writeln("<OPTION VALUE=0" +i+ ">0"+i); 
         }
         
         else{
             if(i==this_day) document.writeln("<OPTION VALUE=" +i+ " selected } >"+i); 
             else document.writeln("<OPTION VALUE=" +i+ ">" +i);  
         }                     
    }         
 document.writeln("</select>일"); 
   
}
</script>
</head>

<form name="form1">
<script> Today('null','null','null'); </script>
</form>
            