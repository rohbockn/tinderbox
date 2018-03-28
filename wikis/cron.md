# Cron

[quick how-to guide](https://help.ubuntu.com/community/CronHowto)

## Edit cron jobs for your user profile:

```crontab -e```

### example entry:

```*/6 7-14 * * 1-5 <path to local repo>/tickerFeed/phase1/executables/collect.sh```
