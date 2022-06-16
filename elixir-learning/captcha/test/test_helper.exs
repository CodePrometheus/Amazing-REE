# start the current node as a manager
:ok = LocalCluster.start()

# start your application tree manually
Application.ensure_all_started(:captcha)

# run all tests!
ExUnit.start()
