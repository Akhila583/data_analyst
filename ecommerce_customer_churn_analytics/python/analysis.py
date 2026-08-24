import pandas as pd
import matplotlib.pyplot as plt

customers = pd.read_csv("../data/customers.csv", parse_dates=["signup_date", "churn_date"])
orders = pd.read_csv("../data/orders.csv", parse_dates=["order_date"])
engagement = pd.read_csv("../data/customer_engagement.csv", parse_dates=["month"])

completed = orders[orders["order_status"] == "Completed"].copy()

# KPI calculations
total_revenue = completed["net_amount"].sum()
customers_count = customers["customer_id"].nunique()
churned = (customers["status"] == "Churned").sum()
churn_rate = churned / customers_count

print(f"Customers: {customers_count:,}")
print(f"Revenue: ₹{total_revenue:,.0f}")
print(f"Churned customers: {churned:,}")
print(f"Churn rate: {churn_rate:.2%}")

# Monthly revenue trend
monthly_revenue = (
    completed.assign(month=completed["order_date"].dt.to_period("M").dt.to_timestamp())
    .groupby("month")["net_amount"]
    .sum()
)

monthly_revenue.plot(kind="line", marker="o", title="Monthly Revenue")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("monthly_revenue.png", dpi=150)
plt.close()

# Churn by segment
segment_churn = (
    customers.assign(churned=(customers["status"] == "Churned").astype(int))
    .groupby("segment")
    .agg(customers=("customer_id","count"), churned=("churned","sum"))
)
segment_churn["churn_rate"] = segment_churn["churned"] / segment_churn["customers"]
print("\nChurn by segment:")
print(segment_churn.sort_values("churn_rate", ascending=False))

# Revenue by product
product_revenue = (
    completed.groupby("product_category")["net_amount"]
    .sum()
    .sort_values(ascending=False)
)
print("\nRevenue by product:")
print(product_revenue)

# Simple risk list
recent = engagement[engagement["month"] >= "2026-04-01"].groupby("customer_id").agg(
    avg_sessions=("sessions","mean"),
    support_tickets=("support_tickets","sum")
).reset_index()

risk = customers.merge(recent, on="customer_id", how="left")
risk["risk_score"] = (
    (risk["status"] == "Churned").astype(int) * 3
    + (risk["avg_sessions"].fillna(0) < 3).astype(int) * 2
    + (risk["support_tickets"].fillna(0) >= 2).astype(int)
)
risk = risk.sort_values(["risk_score","avg_sessions"], ascending=[False, True])

risk[[
    "customer_id","segment","plan","status","avg_sessions",
    "support_tickets","risk_score"
]].head(25).to_csv("top_25_customer_risk.csv", index=False)

print("\nTop 25 risk customers saved to top_25_customer_risk.csv")
