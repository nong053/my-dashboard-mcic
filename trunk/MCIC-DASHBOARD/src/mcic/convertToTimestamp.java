package mcic;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class convertToTimestamp {
	public void convertTime() throws ParseException{
		String t2,st = "16/08/2007 09:04:34";
		SimpleDateFormat sdf = new SimpleDateFormat("dd/mm/yyyy hh:mm:ss");
		Date date = sdf.parse(st);
		Timestamp timestamp = new Timestamp(date.getTime());
		t2 = timestamp.toString();
		System.out.print("t2"+t2);
		// T2 will show: "2007-01-16 09:04:34.0"
	}
}
