### Steps for using FirstData Credit Card Payment form

1. Gather data required for generating a MD5 hash
	* `x_login, transaction_key, x_fp_sequence, x_fp_timestamp, x_amount, x_currency_mode`
		1. `x-login` - provided by FirstData
		2. `transaction_key` - provided by FirstData
		3. `x_fp_sequence` - Random number between 1000 - 100000
		4. `x_fp_timestamp` - UTC Timestamp in Integer format
		5. `x_amount` - Amount to be paid
		6. `x_currency_mode` - USD
2. Generate MD5 hash using `OpenSSL::HMAC` in `Ruby`.

```ruby
hmac_data = X_LOGIN + "^" + @fp_sequence.to_s + "^" + @timestamp.to_s + "^" + @amount.to_s + "^" + @currency_mode
x_fp_hash = OpenSSL::HMAC.hexdigest('md5', TRANSACTION_KEY, hmac_data)
```

3. `POST` to FirstData URL
	* Include all the parameters above in the form, along with the generated MD5 hash
	* Use `Net::HTTP::Post` and `Net::HTTP.use_ssl = true`
	* `POST` returns a check cookie URL. Parse HTML and extract link for payment form
