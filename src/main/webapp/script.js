document.addEventListener('DOMContentLoaded', () => {
    const board = document.getElementById('board');
    const cells = Array.from(document.getElementsByClassName('cell'));
    const resetButton = document.getElementById('resetButton');
    const resultScreen = document.getElementById('resultScreen');
    const resultMessage = document.getElementById('resultMessage');
    const newGameButton = document.getElementById('newGameButton');
    const playerX = 'X';
    const playerO = 'O';
    let currentPlayer = playerX;
    let gameState = Array(9).fill(null);

    const winningCombos = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ];

    function handleClick(e) {
        const cell = e.target;
        const index = cell.getAttribute('data-index');

        if (gameState[index] || checkWin()) return;

        gameState[index] = currentPlayer;
        cell.innerText = currentPlayer;
        if (checkWin()) {
            showResult(`${currentPlayer} wins!`);
        } else if (gameState.every(cell => cell)) {
            showResult(`It's a draw!`);
        } else {
            currentPlayer = currentPlayer === playerX ? playerO : playerX;
        }
    }

    function checkWin() {
        return winningCombos.some(combo => {
            return combo.every(index => gameState[index] === currentPlayer);
        });
    }

    function resetGame() {
        gameState.fill(null);
        cells.forEach(cell => (cell.innerText = ''));
        currentPlayer = playerX;
        resultScreen.style.display = 'none';
        board.style.display = 'grid';
    }

    function showResult(message) {
        resultMessage.innerText = message;
        resultScreen.style.display = 'flex';
        board.style.display = 'none';
    }

    cells.forEach(cell => cell.addEventListener('click', handleClick));
    resetButton.addEventListener('click', resetGame);
    newGameButton.addEventListener('click', resetGame);
});
