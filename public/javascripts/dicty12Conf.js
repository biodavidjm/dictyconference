var oneDay = 24 * 60 * 60 * 1000;
var to_currency = '';

$(document).ready(function() {

	$('#user_check_in').datepicker({
		dateFormat: 'MM d, yy',
		minDate: new Date(2013, 7 - 1, 15),
		maxDate: new Date(2013, 8 - 1, 25),
		showWeek: true,
		numberOfMonths: 2 //,
	});

	$('#user_check_out').datepicker({
		dateFormat: 'MM d, yy',
		minDate: new Date(2013, 7 - 1, 15),
		maxDate: new Date(2013, 8 - 1, 25),
		showWeek: true,
		numberOfMonths: 2 //,
	});

	$('#user_has_guest').attr({
		'checked': false,
		'disabled': true
	}).click(function() {
		showGuestOptions();
	});

	$('#extra_view_price').hide();
	$('#extra_view_price').val('');
	$('#user_check_in').hide();
	$('#user_check_out').hide();
	$('#user_extra_accommodation').attr('checked', false).click(function() {
		showExtraAccOptions();
	});

	$('#user_guest_trip').hide();
	$('#user_guest_double_no_BDB').hide();
	$('#user_guest_double_BDB').hide();
	$('#user_guest_single_no_BDB').hide();
	$('#user_guest_single_BDB').hide();
	$('label[for="label_guest_dinner_trip"]').hide();
	$('label[for="label_guest_double_no_BDB"]').hide();
	$('label[for="label_guest_double_BDB"]').hide();
	$('label[for="label_guest_single_BDB"]').hide();
	$('label[for="label_guest_single_no_BDB"]').hide();

	$('#view_price').hide();
	$('#user_roomie_first_name').hide();
	$('#user_roomie_last_name').hide();
	$('label[for="label_roomie_name"]').hide();

	$("input[type=radio]").attr('checked', false).click(function() {
		showPrice();
	});

	$('#user_payment_due').val('');
	$('#user_payment_due').css({
		'font-weight': 'bold',
		'font-size': '12px',
		'color': 'black',
		'border': 'none',
		'background-color': 'white'
	}).hide();

	$('label[for="user_payment_due"]').hide();

	$('#converted_currency').hide();
	$('#converted_currency').val('');
	$('#converted_currency').css({ //'font-weight': 'bold',
		'font-size': '12px',
		'color': 'black',
		'border': 'none',
		'background-color': 'white'
	});

	$('select#to_currency').click(function() {
		to_currency = $('select#to_currency :selected').val();
	}).hide();
});

$.getJSON('http://openexchangerates.org/latest.json', function(data) {
		"use strict";
		if (typeof fx !== "undefined" && fx.rates) {
			fx.rates = data.rates;
			fx.base = data.base;
		} else {
			var fxSetup = {
				rates: data.rates,
	base: data.base
			};
		}
		});

$(document).click(function() {
	"use strict";
	paymentDue();
});


/* Method to calculate payment due depending on whether the registration is early or late
 *
 */
function paymentDue() {
	"use strict";
	var final_amount = 0;
	$('#user_payment_due').show();
	$('label[for="user_payment_due"]').show();
	$('#converted_currency').show();
	$('select#to_currency').show();

	if ($('#user_accommodation_type_single_use').is(':checked')) {
		if (getRegistrationType() === 'Early Registration') {
			alert(getRegistrationType())
				final_amount += 1200;
		} else if (getRegistrationType() === 'Late Registration') {
			final_amount += 1300;
		}
	} else if ($('#user_accommodation_type_double_use').is(':checked')) {
		if (getRegistrationType() === 'Early Registration') {
			final_amount += 950;
		} else if (getRegistrationType() === 'Late Registration') {
			final_amount += 1050;
		}
	}

	if ($('#user_has_guest').is(':checked')) {
		if ($('#user_accommodation_type_single_use').is(':checked')) {
			if ($('#user_guest_single_BDB').is(':checked')) {
				final_amount += 738;
			} else if ($('#user_guest_single_no_BDB').is(':checked')) {
				final_amount += 536;
			}
		} else if ($('#user_accommodation_type_double_use').is(':checked')) {
			if ($('#user_guest_double_BDB').is(':checked')) {
				final_amount += 470;
			} else if ($('#user_guest_double_no_BDB').is(':checked')) {
				final_amount += 268;
			}
		}
		if ($('#user_guest_trip').is(':checked')) {
			final_amount += 50;
		}
	}

	if ($('#user_extra_accommodation').is(':checked')) {
		var num_days = 0;

		var checkin = new Date($('#user_check_in').val());
		var checkout = new Date($('#user_check_out').val());
		num_days = getNonDictyDays(checkin, checkout);

		if ($('#user_accommodation_type_single_use').is(':checked') && $('#user_check_in').val() !== '' && $('#user_check_out').val() !== '') {
			final_amount += 134 * num_days;
		} else if ($('#user_accommodation_type_double_use').is(':checked') && $('#user_check_in').val() !== '' && $('#user_check_out').val() !== '') {
			final_amount += 134 * num_days;
		}
	}

	$('#user_payment_due').val("$" + final_amount.toFixed(2));

	var converted = 0;
	if (to_currency !== '') {
		converted = fx.convert(final_amount, {
			from: "EUR",
			to: to_currency
		}).toFixed(2);
	}
	$('#converted_currency').val(converted);
}

// function currencyConverter(amount) {
//     var url = 'http://www.google.com/finance/converter?';
//     var data = 'a=' + amount + '&from=EUR&to=' + to_currency;
//     $.ajax({
//         url: url,
//         dataType: 'json',
//         data: data + "?callback=?",
//         success: function(msg) {
//             var currency = $.parseJSON(msg);
//             alert (currency ['rhs'];);
//             return 0;
//         }
//     });
// $.getJSON(url + data + "?callback=?", function(currency)) {
//     alert(currency)
// }
// }

/* 
 *
 */
function getNonDictyDays(startDate, endDate) {
	"use strict";
	var dicty12Start = new Date(2013, 8 - 1, 4);
	var dicty12End = new Date(2013, 8 - 1, 8);
	var days = 0;

	if ((startDate < dicty12Start) && (endDate <= dicty12End) && (endDate > dicty12Start)) {
		days = Math.abs((dicty12Start.getTime() - startDate.getTime()) / oneDay);
	} else if ((startDate >= dicty12Start) && (dicty12End < endDate) && (startDate < dicty12End)) {
		days = Math.abs((endDate.getTime() - dicty12End.getTime()) / oneDay);
	} else if ((startDate < dicty12Start) && (endDate < dicty12End)) {
		days = 0;
	} else if ((startDate < dicty12Start) && (endDate > dicty12End)) {
		days = Math.abs((dicty12Start.getTime() - startDate.getTime()) / oneDay) + Math.abs((endDate.getTime() - dicty12End.getTime()) / oneDay);
	}
	return days;
}

/* 
 *
 */
function showExtraAccOptions() {
	"use strict";
	$('#extra_view_price').css({
		'font-weight': 'bold',
		'font-size': '12px',
		'color': 'black',
		'border': 'none',
		'background-color': 'white'
	});
	if ($('#user_extra_accommodation').is(':checked')) {
		$('#extra_view_price').show();
		$('#user_check_in').show();
		$('#user_check_out').show();
	} else {
		$('#extra_view_price').hide();
		$('#user_check_in').hide();
		$('#user_check_out').hide();
		$('#user_check_in').val('');
		$('#user_check_out').val('');
	}
}

/* Method to check what type of registration it is
 * either Early or Late
 */
function getRegistrationType() {
	"use strict";
	var registration_type;
	var early = Date.parse("7/15/2013"); // May 31, 2013
	var late = Date.parse("8/4/2013"); // July 23, 2013
	if (Date.now() <= early) {
		registration_type = 'Early Registration';
	} else if (Date.now() > early && Date.now() <= late) {
		registration_type = 'Late Registration';
	}
	return registration_type;
}

/* 
 *
 */
function showPrice() {
	"use strict";
	$('#view_price').show();
	$('#view_price').css({
		'font-weight': 'bold',
		'font-size': '12px',
		'color': 'black',
		'border': 'none',
		'background-color': 'white'
	});

	if ($('#user_accommodation_type_double_use').is(':checked')) {
		$('label[for="label_roomie_name"]').show();
		$('#user_roomie_first_name').show();
		$('#user_roomie_last_name').show();

		$('#user_has_guest').attr('disabled', false);

		$('#extra_view_price').val('$67 (per night, per person)');

		if (getRegistrationType() === 'Early Registration') {
			$('#view_price').val('Early Registration: $950 (per person)');
		} else if (getRegistrationType() === 'Late Registration') {
			$('#view_price').val('Late Registration: $1050 (per person)');
		}
	} else if ($('#user_accommodation_type_single_use').is(':checked')) {
		$('#user_roomie_first_name').hide();
		$('#user_roomie_last_name').hide();
		$('label[for="label_roomie_name"]').hide();

		$('#user_has_guest').attr('disabled', false);

		$('#user_guest_trip').hide();
		$('#user_guest_supplement_HB').hide();
		$('#user_guest_supplement_HBD').hide();
		$('label[for="label_guest_dinner_trip"]').hide();
		$('label[for="label_guest_supplement_1"]').hide();
		$('label[for="label_guest_supplement_2"]').hide();

		$('#extra_view_price').val('$134 (per night)');

		if (getRegistrationType() === 'Early Registration') {
			$('#view_price').val('Early Registration: $1200');
		} else if (getRegistrationType() === 'Late Registration') {
			$('#view_price').val('Late Registration: $1300');
		}
	}

	$('#user_accommodation_type_single_use').click(function() {
		$('#user_roomie_first_name').val('');
		$('#user_roomie_last_name').val('');
	});
}

/* 
 *
 */
function showGuestOptions() {
	"use strict";
	if ($('#user_has_guest').is(':checked')) {
		$('#user_guest_trip').show();
		$('label[for="label_guest_dinner_trip"]').show();
		if ($('#user_accommodation_type_single_use').is(':checked')) {
			$('#user_guest_single_BDB').show();
			$('#user_guest_single_no_BDB').show();
			$('label[for="label_guest_single_no_BDB"]').show();
			$('label[for="label_guest_single_BDB"]').show();

		} else if ($('#user_accommodation_type_double_use').is(':checked')) {
			$('#user_guest_double_BDB').show();
			$('#user_guest_double_no_BDB').show();
			$('label[for="label_guest_double_no_BDB"]').show();
			$('label[for="label_guest_double_BDB"]').show();
		}
	} else {
		$('#user_guest_trip').attr('checked', false).hide();
		$('#user_guest_single_BDB').attr('checked', false).hide();
		$('#user_guest_single_no_BDB').attr('checked', false).hide();
		$('#user_guest_double_BDB').attr('checked', false).hide();
		$('#user_guest_double_no_BDB').attr('checked', false).hide();
		$('label[for="label_guest_dinner_trip"]').hide();
		$('label[for="label_guest_single_no_BDB"]').hide();
		$('label[for="label_guest_single_BDB"]').hide();
		$('label[for="label_guest_double_BDB"]').hide();
		$('label[for="label_guest_double_no_BDB"]').hide();
	}

	$('#user_guest_single_BDB').click(function() {
		$('#user_guest_single_BDB').attr('checked', true);
		$('#user_guest_single_no_BDB').attr('checked', false);
	});

	$('#user_guest_single_no_BDB').click(function() {
		$('#user_guest_single_no_BDB').attr('checked', true);
		$('#user_guest_single_BDB').attr('checked', false);
	});

	$('#user_guest_double_no_BDB').click(function() {
		$('#user_guest_double_no_BDB').attr('checked', true);
		$('#user_guest_double_BDB').attr('checked', false);
	});
	$('#user_guest_double_BDB').click(function() {
		$('#user_guest_double_BDB').attr('checked', true);
		$('#user_guest_double_no_BDB').attr('checked', false);
	});
}
