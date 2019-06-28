/**
 * 
 */
function dateString(mSec) {
	var d = new Date(mSec); // mSec ; 밀리세컨드
	var year = d.getFullYear(); // 년도
	var month = d.getMonth() + 1; // 월
	var date = d.getDate(); // 일
	var hour = d.getHours(); // 시간
	var minute = d.getMinutes(); // 분
	var sec = d.getSeconds(); // 초

	return year + "/" + make2Digits(month) + "/" + make2Digits(date) + " "
			+ make2Digits(hour) + ":" + make2Digits(minute) + ":"
			+ make2Digits(sec);
}

function make2Digits(digit) {
	if (digit < 10) {
		return "0" + digit;
	} else {
		return digit;
	}
}
function isImage(fileName) { // 97ae61f1-d8d4-4613-ae29-3eb14b7dcaed_Desert.jpg
	// 넘겨받은 파일명(파일명.확장명)에서 확장자 얻기
	// .의 위치 얻어내기
	var dotIndex = fileName.lastIndexOf(".");
	var formatName = fileName.substring(dotIndex +1).toUpperCase(); // JPG
	if (formatName == "JPG" || formatName == "PNG" || formatName == "GIF") {
		return true;
	}
	return false;
	
	// 확장자가 - JPG, PNG, GIF - true, false
	
	
}
