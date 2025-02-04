import 'package:get/get.dart';
import 'package:highties_cannabis/components/export.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart';

class CommonMethod {
  double convertToDouble(dynamic value) {
    if (value is double) {
      // If it's already a double, no conversion needed
      return value;
    } else if (value is int) {
      // If it's an int, convert to double
      return value.toDouble();
    } else if (value is String) {
      // If it's a string, parse and convert to double
      return double.parse(value);
    } else {
      // If it's none of the above, return NaN or handle it based on your requirements
      return double.nan;
    }
  }

  round2(number, [decimalPlaces = 2]) {
    return double.parse(number.toStringAsFixed(decimalPlaces));
  }

  getImageUrl(img) {
    // generate full url of image from partial path of server.
    if (img != null && img.isEmpty) return '';
    var extraSlash = '';
    if (img[0] != '/') extraSlash = '/';
    return ApiAppConstants.apiRootUrl + '$extraSlash$img';
  }

  Map<String, String> currentDateFormats() {
    tzdata.initializeTimeZones();
    // Get the New York time zone
    final newYork = getLocation('America/New_York');

    // Create a TZDateTime using the New York time zone
    final TZDateTime now = TZDateTime.now(newYork);
    final TZDateTime nextDay = now.add(Duration(days: 1));

    final DateFormat fullDateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.S');
    final DateFormat dateWithoutSecFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat isoDateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormat = DateFormat('H:mm:ss');

    final String date = fullDateFormat.format(now);
    final String dateWithoutSec = dateWithoutSecFormat.format(now);
    final String isoDate = isoDateFormat.format(now);
    final String time = timeFormat.format(now);
    final String nextDate = dateWithoutSecFormat.format(nextDay);
    final String nextFullDate = fullDateFormat.format(nextDay);

    return {
      'full_date': date,
      'date': dateWithoutSec,
      'iso_date': isoDate,
      'time': time,
      'next_date': nextDate,
      'next_full_date': nextFullDate,
    };
  }

  void main() {
    final Map<String, String> dateFormats = currentDateFormats();
    print(dateFormats);
  }

  String ddMmYyyyToISO(String dateInput) {
    if(dateInput.isEmpty) {
      return '';
    }
    List<String> parts = dateInput.split('-');
    String formattedDate = "${parts[2]}-${parts[1]}-${parts[0]}";
    return formattedDate;
  }
  
  String sliceText(String text, [ int maxLength= 20]) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  void showToast(BuildContext context,
      {String title= '', String message= '', type= 'success'}) {
    // todo: show toast work
    print('title: $title, message: $message');
    var color = type == 'info' ? Color(0xef817f84) : type == 'success' ? Color(0xef148D14) : Color(0xefFA4E53);
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        backgroundColor: color,
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
          size: 35,
        ),
        borderRadius: 24,
        duration: Duration(seconds: 2),
        isDismissible: false,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.GROUNDED,
      ),
    );

    return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width-380) / 2, vertical: 20),

        // margin: EdgeInsets.fromLTRB(
        //   // MediaQuery.of(context).size.width -400,
        //   MediaQuery.of(context).size.width - 400,
        //   0,
        //   0,
        //   50,
        // ),
        content: Container(
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          padding: EdgeInsets.fromLTRB(20, 5, 7, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ],
              ),
              Text(
                message,
                style: TextStyle(fontSize: 12, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: type == 'success' ? Color(0xef148D14) : Color(0xefFA4E53),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  void showSnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String encodeQueryString(
      String baseUrl, Map<String, String> queryParams) {
    // Encode the query parameters
    List<String> encodedQueryParams = [];
    queryParams.forEach((key, value) {
      encodedQueryParams.add('${Uri.encodeQueryComponent(key)}=${(value)}');
    });

    // Join the encoded query parameters with '&'
    String queryString = encodedQueryParams.join('&');

    // Combine the base URL and the query string
    String fullUrl = '$baseUrl?$queryString';

    return fullUrl;
  }
}

// mov
// webm
// mpg
// wmv
