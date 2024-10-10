# git_prompt

`git_prompt` is a Bash script that modifies your Linux terminal prompt (PS1) to display information about the current Git repository. It uses only the `git`, `basename`, and `cut` commands to extract and show this information.

![Git Prompt Example](example.png)

## Installation

To install `git_prompt`, follow these simple steps:

1. **Download the `bash_git_prompt` file**:
   - Copy the `bash_git_prompt` file to your home directory (or to your preferred directory).

2. **Modify your `.bashrc` file**:
   - Open your `.bashrc` file in a text editor. You can use `nano`, `vim`, or any other editor of your choice. For example:
     ```bash
     nano ~/.bashrc
     ```

3. **Add the following code at the end of your `.bashrc` file**:
   ```bash
   if [ -f ~/.bash_git_prompt ]; then
       source ~/.bash_git_prompt
   fi
   ```

4. **Reload your `.bashrc` file**:
   - To apply the changes, run the following command in your terminal:
     ```bash
     source ~/.bashrc
     ```

## Usage

Once installed, your command prompt will automatically display information about the current Git repository whenever you navigate to a directory containing a Git repository.

## Notes

- Make sure the `bash_git_prompt` file is executable. You can make it executable with the following command:
  ```bash
  chmod +x ~/.bash_git_prompt
  ```

- If you encounter any issues or have questions, feel free to open an issue in this repository.