#!/bin/zsh

install() {
  echo "Enter relative path to archive (.tgz):"
  read path

  if [ -f "$path" ]; then
    tar -xzf "$path" -C ~/kafka-extracted # Specify the destination path
    echo "Extraction complete."

    # After extracting, execute the command in the Kafka folder
    (cd ~/kafka-extracted && bin/kafka-topics.sh --create --topic testTopic --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1)
  else
    echo "File not found."
  fi
}

run_test() {
  cd ~/kafka-extracted/bin
  
  open -a Terminal.app zsh -c "./kafka-topics.sh --create --topic testTopic --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1"
  open -a Terminal.app zsh -c "./kafka-console-producer.sh --topic testTopic --bootstrap-server localhost:9092"
  open -a Terminal.app zsh -c "./kafka-console-consumer.sh --topic testTopic --from-beginning --bootstrap-server localhost:9092"
}


echo "Welcome to Kafka Z-Shell Automator!"
echo "If you haven't installed yet, type 1 and I will install Kafka to ~/kafka-extracted path; if you already done that and just want to run a test, just press 2, note: the test will assume the same path too:"
read type

if [ "$type" -eq 1 ]; then
  install
elif [ "$type" -eq 2 ]; then
  run_test
else
  echo "Wrong input format."
fi
