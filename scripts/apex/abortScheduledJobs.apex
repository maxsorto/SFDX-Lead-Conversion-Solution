List<CronTrigger> jobsToAbort = [SELECT Id FROM CronTrigger WHERE State = 'WAITING' OR State = 'ACQUIRED' OR State = 'EXECUTING'];
for (CronTrigger job : jobsToAbort) {
    System.abortJob(job.Id);
}
