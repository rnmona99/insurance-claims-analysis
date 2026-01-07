SELECT status, COUNT(*) FROM claims GROUP BY status;
SELECT p.provider_name, SUM(c.total_claimed_amount)
FROM claims c
JOIN providers p ON p.provider_id = c.provider_id
GROUP BY p.provider_name;
