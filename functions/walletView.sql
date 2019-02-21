CREATE VIEW wallet AS
SELECT users.name            AS name,
       accounts.balance      AS account_balance,
       accounts.number       AS account_number,
       credit_types.name     AS credit,
       credits.value         AS credit_value,
       investment_types.name AS investment,
       investments.start_date
FROM ((((users LEFT JOIN accounts on users.user_id = accounts.user_id)
  LEFT JOIN credits ON accounts.user_id = credits.user_id )
  LEFT JOIN credit_types ON credit_types.credit_type_id = credits.credit_type_id)
  LEFT JOIN investments ON credits.user_id = investments.user_id)
  LEFT JOIN investment_types ON investments.investment_type_id = investment_types.investment_type_id;


drop VIEW wallet;

select * FROM wallet;