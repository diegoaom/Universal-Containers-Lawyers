# Salesforce Bootcamp - Final Project

This is the final project of the Salesforce Bootcamp made by Altimetrik in 2023

## Universal Containers Lawyers

Universal Containers Lawyers is a company that provides legal advisory to their customers.
They consume data from an external system that stores the information into Heroku on a daily
basis.
They want to adopt Salesforce and need to migrate the information stored in Heroku into an org.
The data is retrieved as a JSON, and contains two types of entities: ‘Legal Advisor’, and ‘Client’.
There is a web service in Heroku that contains the json file. Also, given that this information
changes periodically, they need a way to do this process automatically every day.
Legal Advisors are firms that provide legal services to different clients. Clients are the ones that
hire the advisors services.
Legal Advisors are uniquely identified by its Account Number.
Clients are uniquely identified by its Account Number + Client Number. Note that a client can
only be related to just one Legal Advisor. Each Legal Advisor assigns a unique Client Number.
However, the Client Number may not be unique across Legal Advisors.
They ask that all classes you create have the prefix ‘ucl_’. For example: ‘ucl_LegalAdvisors.cls’
It is worth noting that Universal Containers has a QA team that will be in charge of validating the
functionality you implement.

## Useful links

- [Invoking Callouts Using Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_callouts.htm)
- [Apex REST callouts unit](https://trailhead.salesforce.com/en/content/learn/modules/apex_integration_services/apex_integration_rest_callouts)
- [Schedule Jobs Using the Apex Scheduler](https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_scheduled)
- [Adding a related list](https://www.marksgroup.net/blog/salesforce-com-adding-a-related-list/)
