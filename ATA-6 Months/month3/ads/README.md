## Architectural Design Session - MoonPass Case Study

### Team Activity

1. As a team, review the following customer case study
2. Research Azure services and put together an architecture that meets customer needs (feel free to use Azure services that have not been discussed in class)
3. Provide a cost estimate of the proposed solution
4. Implement part of the solution (be as creative as possible)
5. As a team, present the architecture and cost to the rest of the class and do a small demo of your implementation


### Customer situation

MoonPass, Ltd. was founded in 2011 in Miami, FL, and provides custom software development solutions for a number of clients. In addition to custom software development, they also have developed a financial billing and payment suite of software aimed at several vertical markets, from e-commerce to medical, financial services. They have recently added toll road booth management, as a new market opportunity opened to handle vehicle tracking and toll billing near their home office. Since this new business venture was a minor addition to their impressive portfolio of billing services, they have not dedicated significant resources to the vehicle processing portion of their custom-built TollBooth software suite. The most feature-rich component of this software suite is their existing payment management system that has been expanded to send bills to drivers after passing through any number of the managed toll booths. Included in the bill are a date/time stamp, toll booth location, and a photo of the vehicle as it passed through the booth.

Because so few resources were applied to the TollBooth software, which was meant to handle just a handful of local toll booths, MoonPass has been using a manual process to identify license plates and send that data to their billing software. As a car passes through a toll booth, a medium resolution image is taken of the car to identify its license plate numbers/characters which will ultimately be used to look up and bill the customer. Currently, they periodically package and send those images to a third-party vendor, who manually identifies the license plate numbers and sends the list back to MoonPass when they are done. At this point, MoonPass collects batches of 1,000 transactions, saves the information to a CSV file hosted by an FTP server, where their downstream accounting system extracts the license plate information and bills the customer.

MoonPass has recently been awarded a large, yet unexpected contract to manage toll booths across most of the state, resulting in a 2500% increase in coverage, and is in talks with Oklahoma and New Mexico to provide toll booth services in those states as well. Despite the obvious benefits of such rapid growth, the company is concerned that they will be unable to meet the demand that comes with it. They are confident that their billing software can handle the load, as it has been the primary focus of development from the start, and has expanded into other markets, proving its ability to handle large-scale transactions and data processing. However, MoonPass is concerned about how rapidly they can automate the license plate processing portion of their TollBooth infrastructure, while ensuring that the automated solution can scale to meet demand, particularly during unexpected spikes in traffic.

"What we need is a lightweight, yet powerful method that quickly pulls in vehicle photos as they are uploaded, and intelligently detect the license plate numbers, all while efficiently handling spikes in traffic," says Abby Burris, CIO, MoonPass, ltd. "Most importantly, we do not want to manage long-lived application instances, we want to minimize our cost during slow traffic periods, and we need something our developers can quickly integrate into our existing infrastructure without a lot of training. Our primary goal is to rapidly replace this manual processing pipeline while continuing to devote our development resources to our core billing platform services."

Abby went on to say that she has been following the relatively new native cloud services movement and believes that its benefits brings a good match for what they are hoping to achieve in this project. The fewer infrastructure responsibilities for the already maxed out IT team, the better.

Since MoonPass does not have any machine learning experts or data scientists on staff, they would like to know their options for using a ready-made machine learning service that can perform the license plate recognition task on the photos. They would prefer to go this route, rather than to train their staff to properly create and train advanced machine learning models, then having to incur the cost of hosting their own machine learning service for conducting this one task.

MoonPass wants to store captured vehicle photos in cloud storage for retrieval via custom web and mobile applications. These photos will need to be accessible by the downstream billing service for inclusion on the customer bills. Also, any photos containing license plates that could not be automatically detected will need to be marked as such and accessed later on for manual validation. Similarly, as photos are successfully processed for license plate detection, the plate information needs to be saved to a database, along with the capture date/time and tollbooth Id. MoonPass has a customer service department who can monitor the queue of photos marked for manual validation, and enter the license plates into a web-based form so they can be exported along with the automatically processed license plate data.

The process to export license plate data also needs to be automated. MoonPass would like an automated workflow that runs on a regular interval to extract new license plate data since the last export and saves it in a CSV file that gets ingested by the billing software. They already have the CSV ingest process automated, so no changes are required beyond saving the file. Their FTP server would need to be modified to point to the cloud storage container instead of its local file system, which is a simple process that is out of scope for the automation task. The export interval should be set to one hour but be flexible to increasing or decreasing the interval as needed. This interval is based on the automated file ingest process used by the billing system.

Customer service has requested that an alert email should be sent to a specific monitoring address if at any point the automated export does not complete due to no data. Given the export interval and the average number of vehicles that pass through the toll booths during any given hour, having no data to export would be the exception, not the rule. The alert would give them the peace of mind that they could go through internal support channels to investigate the license processing pipeline to address any issues promptly, without being inundated by too many unnecessary alert notifications. They are using Office 365 for their email services.

In addition to the email alert notifications, MoonPass would like to have a centralized monitoring dashboard they can use to watch the automated process in real time and drill down into historical telemetry later on if needed. This dashboard will help them keep an eye on the various Azure components, watching for any bottlenecks or weak points in their overall solution. The monitoring dashboard should also allow them to add custom alert notifications that get sent to IT staff if anything goes wrong.

"Our directors want to see where we can take the notion of a PaaS architecture and cloud native services to see if there truly are long-term performance and cost benefits," says Burris. "With the unexpected windfall of the toll booths contract, they want to make sure we have a tested strategy we can fall back on in the future when our IT and development teams are called upon once again to achieve the impossible."

As a stretch goal, MoonPass would like to know that the license processing pipeline they have implemented is extensible to any number of future scenarios that are made possible once the license plate has been successfully processed. The one scenario they currently have in mind is how the pipeline would support more advanced analytics, providing the capability to process the licenses plates in a streaming fashion as well as to process historical license plate capture events in a batch fashion (e.g., that could scale to analyze the historical data in the 10's of terabytes).

### Customer needs

1. Replace manual process with a reliable, automated solution using as many cloud native services/components as possible.

2. Take advantage of a machine learning service that would allow them to accurately detect license plate numbers without needing artificial intelligence expertise.

3. Mechanism for manually entering license plate images that could not be processed.

4. Have a solution that can scale to any number of cars that pass through all toll booths, handling unforeseen traffic conditions that cause unexpected spikes in processed images.

5. Establish an automated workflow that periodically exports processed license plate data on a regular interval, and sends an alert email when no items are exported.

6. Would like to develop an automated deployment pipeline from source control.

7. Use a monitoring dashboard that can provide a real-time view of components, historical telemetry data for deeper analysis, and supports custom alerts.

8. Design an extensible solution that could support batch and real-time analytics, as well as other scenarios in the future.
