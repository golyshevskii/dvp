DBT flow :building_construction:
----

For launching the models located in the directory `models/`, the following commands can be used:

Model execution
```
dbt run -s +[model_name]
```

Model full refresh execution
```
dbt run -s +[model_name] --full-refresh
```

***

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
