QUESTION 1
SELECT COUNT (u_id) FROM Public.users;

QUSTION 2
SELECT COUNT (transfer_id) from Public.transfers WHERE send_amount_currency= 'CFA';

QUSTION 3
SELECT distinct(count(u_id))from Public.transfers WHERE send_amount_currency= 'CFA';

QUESTION 4
SELECT COUNT(atx_id) FROM Public.agent_transactions WHERE EXTRACT(Year from when_created)=2018
GROUP BY EXTRACT(MONTH FROM when_created);

QUSTION 5
SELECT COUNT (agent_id) AS netwithdrawers FROM agent_transactions HAVING count (amount) IN 
(SELECT COUNT (amount) FROM Public.agent_transactions WHERE amount > -1
AND amount !=0 HAVING COUNT (amount) > (SELECT COUNT (amount) FROM Public.agent_transactions 
WHERE amount < 1 AND amount !=0));

QUESTION 6
SELECT City, Volume, Country INTO atx_city_volume_summary_with_country FROM ( Select agents.city AS City, agents.country AS Country, count(agent_transactions.atx_id) AS Volume FROM agents 
INNER JOIN agent_transactions ON agents.agent_id = agent_transactions.agent_id where (agent_transactions.when_created > (NOW() - INTERVAL '1 week'))
GROUP BY agents.country,agents.city) as atx_city_volume_summary_with_Country;

QUSETION 7
SELECT COUNT(atx_id) AS volume, city, country
FROM public.agent_transactions
INNER JOIN public.agents ON agents.agent_id = agent_transactions.agent_id
WHERE agent_transactions.when_created > now() -INTERVAL '7 days'
GROUP BY city, country;

QUSETION 8
SELECT transfers.kind AS Kind, wallets.ledger_location AS Country, sum(transfers.send_amount_scalar) AS Volume 
FROM transfers
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id where (transfers.when_created > (NOW() - INTERVAL '1 week')) 
GROUP BY wallets.ledger_location, transfers.kind;

QUESTION 9
SELECT count(transfers.source_wallet_id) AS Unique_Senders, count(transfer_id) AS Transaction_count, transfers.kind AS Transfer_Kind, wallets.ledger_location AS Country, 
sum(transfers.send_amount_scalar) AS Volume FROM transfers 
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id where (transfers.when_created > (NOW() - INTERVAL '1 week'))
GROUP BY wallets.ledger_location, transfers.kind;

QUSETION 10
SELECT transfers.source_wallet_id, send_amount_scalar 
FROM transfers WHERE send_amount_currency = 'CFA' 
AND (send_amount_scalar>10000000) AND (transfers.when_created > (NOW() - INTERVAL '1 month'));
