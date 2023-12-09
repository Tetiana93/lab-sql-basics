select client_id from client
where district_id = 1
limit 5;
select client_id from client
where district_id = 72
order by client_id desc
limit 1;
select amount from loan
order by amount
limit 3; 
select status from loan
group by status 
order by status;
-- we have an incorrect condition in the exercise "What is the loan_id of the highest payment received in the loan table?" Answer 6312, but it's min payments
select loan_id from loan
where payments in (select max(payments) from loan); 
select loan_id from loan
where payments in (select min(payments) from loan);
select account_id, amount from loan
order by account_id
limit 5;
select account_id from loan 
where duration=60
order by amount
limit 5;
select distinct k_symbol from `order`
order by k_symbol;
select order_id from `order`
where account_id = 34;
select distinct account_id from `order`
where order_id between 29540 and 29560;
select amount  from `order`
where account_to = 30067122;
select trans_id, date, type, amount from trans
where account_id=793
order by date desc
limit 10;
select district_id, count(district_id) from client
group by district_id
having  district_id < 10
order by district_id;
select type, count(type) from card
group by type
order by count(type) desc;
select account_id, sum(amount) as res from loan
group by account_id
order by res desc
limit 10;
select * from loan;
select date, count(loan_id) from loan
group by date
having date < 930907
order by date desc; 
select distinct date, duration, count(loan_id) from loan
group by date, duration
having date like '9712%'
order by date, duration;
select account_id, type, sum(amount) as total_amount from trans
group by type, account_id
having  account_id = 396
order by type;
select account_id,
case
when type ='VYDAJ' then 'Outgoing'
else 'Incoming'
end as transaction_type, floor(sum(amount)) as total_amount 
from trans
group by account_id, 
case when type ='VYDAJ' then 'Outgoing'
else 'Incoming'
end
having  account_id = 396
order by transaction_type;

with dif as (select account_id,
case
when type ='VYDAJ' then 'Outgoing'
else 'Incoming'
end as transaction_type, floor(sum(amount)) as total_amount 
from trans
group by account_id, 
case when type ='VYDAJ' then 'Outgoing'
else 'Incoming'
end
having  account_id = 396
order by transaction_type),
dif_1 as (select account_id, total_amount as am1 from dif
where transaction_type='Outgoing'),
dif_2 as (select account_id, total_amount as am2 from dif
where transaction_type='Incoming')
select d.account_id, b.am2, d.am1, b.am2 - d.am1 as differ
from dif_1 as d
join dif_2 as b
on  d.account_id = b.account_id;

select
    account_id,
     round(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END) - SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END),0) AS difference
from
    trans
group by
    account_id
order by difference desc
limit 10;






